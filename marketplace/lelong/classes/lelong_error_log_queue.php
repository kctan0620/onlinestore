<?php
require_once(dirname(__FILE__).'/common.php');
require_once(dirname(__FILE__).'/lelong_config.php');
    
class LelongErrorLogQueue{
    
    public function __construct($db, $logger){
        $this->db = $db;
        $this->_logger = $logger;
        $this->QUEUE_TBL = DB_PREFIX.LELONG_ERROR_LOG_TBL;
    }
    
    public function FetchQueue($limit){
        $this->_logger->writeLog('LelongErrorLogQueue FetchQueue('.$limit.')');
        
        $sql = "SELECT * FROM ".$this->QUEUE_TBL." WHERE notified = 0 AND log_type NOT LIKE '%DEBUG%' ORDER BY create_time ASC LIMIT $limit";
        $result = $this->db->query($sql);
        $this->_logger->writeLog('LelongErrorLogQueue ('.$sql.')');
        $processedResult = array();
        
        if ($result->num_rows > 0) {
            $this->_logger->writeLog('LelongErrorLogQueue FetchQueue('.$limit.')['.$result->num_rows.' rows]');
            $i = 0;
           foreach($result->rows as $row) {
                $processedResult[$i] = $row;
                $queueId = $row['log_id'];
                $this->_logger->writeLog('LelongErrorLogQueue FetchQueue('.$limit.')[ID : '.$queueId .']');
                $i ++;
            }
        }
        else{
            $this->_logger->writeLog('LelongErrorLogQueue FetchQueue('.$limit.') No available Queue');
        }
        
        return $processedResult;
        
    }
    
    public function UpdateQueueStatus($queueId, $status, $productId = null){
        $sql = "UPDATE ".$this->QUEUE_TBL." SET notified = '".$status."' WHERE log_id = ".$queueId."";
       
        $result = $this->db->query($sql);
    }
    
    public function ClearFailedQueue(){
        $sql = "DELETE FROM ".$this->QUEUE_TBL." WHERE DATEDIFF(NOW(), create_time) > 30 AND notified = 0";
        $this->db->query($sql);
    }

    
    public function Push($queues){
        foreach($queues as $queue){
			
			$to      = LELONG_ERROR_EMAIL_RECEIVER;
			$subject = 'Lelong Sync Error Notification #'.$queue['log_id'];
			$message = 'Product Id : '.$queue['product_id']."\r\n\r\n\r\n".$queue['message']."\r\n\r\nDate : ".$queue['create_time'];
			$headers = 'From: webmaster@tmt.my' . "\r\n" .
				'Reply-To: noreply@tmt.my' . "\r\n" .
				'X-Mailer: PHP/' . phpversion();

			$sent = mail($to, $subject, $message, $headers);

            
            echo "[".$queue['log_id']."][".$queue['product_id']."]".$message."\n\n";
			
			if($sent)
				$this->UpdateQueueStatus($queue['log_id'], '1', $queue['product_id']);
        }
	}
}
?>
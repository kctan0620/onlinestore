<?php
require_once(dirname(__FILE__).'/common.php');
require_once(dirname(__FILE__).'/curl_request.php');
    
class LelongSyncQueue{
    
    public function __construct($db, $logger){
        $this->db = $db;
        $this->_logger = $logger;
        $this->curlReq = new curlReq();
        $this->curlReq->setLog($this->_logger);
        $this->QUEUE_TBL = _DB_PREFIX_.LELONG_SYN_QUEUE_TBL;
        $this->LOG_TBL = _DB_PREFIX_.LELONG_SYN_LOG_TBL;
    }
    public function addQueue($productId, $productJson){
        $this->_logger->writeLog('LelongSyncQueue->addQueue : '.$productId);
        $queryStr = 'INSERT INTO '._DB_PREFIX_.LELONG_SYN_QUEUE_TBL.' (product_id, product_json, status, add_date, last_update, retry_count) VALUES ('.$productId.',"'.$this->db->_escape($productJson).'", "P", NOW(), NOW(), 0)';
        
        $this->_logger->writeLog('LelongSyncQueue->addQueue Query : '.$queryStr);
        
        Db::getInstance()->execute($queryStr);
    }
    
    public function FetchQueue($limit){
        $this->_logger->writeLog('LelongQueue FetchQueue('.$limit.')');
        
        $sql = "SELECT * FROM ".$this->QUEUE_TBL." WHERE status IN ('P', 'F') AND retry_count < 3 ORDER BY last_update ASC, queue_id ASC LIMIT $limit";
        $result = $this->db->query($sql);
        $this->_logger->writeLog('LelongQueue ('.$sql.')');
        $processedResult = array();
        
        if ($result->num_rows > 0) {
            $this->_logger->writeLog('LelongQueue FetchQueue('.$limit.')['.$result->num_rows.' rows]');
            $i = 0;
            while($row = $result->fetch_assoc()) {
                $processedResult[$i] = $row;
                $queueId = $row['queue_id'];
                $this->_logger->writeLog('LelongQueue FetchQueue('.$limit.')[ID : '.$queueId .']');
                $this->UpdateQueueStatus($queueId , 'Q');
                $i ++;
            }
        }
        else{
            $this->_logger->writeLog('LelongQueue FetchQueue('.$limit.') No available Queue');
        }
        
        return $processedResult;
        
    }
    
    public function UpdateQueueStatus($queueId, $status){
        $sql = "UPDATE ".$this->QUEUE_TBL." SET status = '".$status."' WHERE queue_id = ".$queueId."";
        if($status == 'Q'){
            $sql = "UPDATE ".$this->QUEUE_TBL." SET status = '".$status."', retry_count = (retry_count + 1) WHERE queue_id = ".$queueId."";
        }
        else if($status == 'F' || $status == 'S'){
            //$sql = "UPDATE wp_posts_log SET queue_status = '".$status."' WHERE ID = ".$prodId." AND queue_status NOT IN ('Q')";
        }
        $result = $this->db->query($sql);
    }
    
    public function ClearFailedQueue(){
        $sql = "DELETE FROM ".$this->QUEUE_TBL." WHERE retry_count >= 3";
        $this->db->query($sql);
    }
    
    private function AddSyncLog($queue){
        $sql = "INSERT INTO ".$this->LOG_TBL."(log_id, product_id, type, status, product_json) VALUES(".$queue['queue_id'].",".$queue['product_id'].",'Q', 'SYNC', '".$this->db->real_escape_string($queue['product_json'])."')";
        $this->db->query($sql);
        return $queue['queue_id'];
    }
    
    private function UpdateSyncLogResponse($logId, $response){
        $sql = "UPDATE ".$this->LOG_TBL." SET status = 'DONE', response = '".$this->db->real_escape_string($response)."' WHERE log_id = ".$logId;
        $this->db->query($sql);
    }
    
    public function Push($queues){
        foreach($queues as $queue){
            $productJson = $queue['product_json'];
            
            echo "[".$queue['queue_id']."][".$queue['product_id']."]".$productJson."\n\n";
            $logId = $this->AddSyncLog($queue);
            $params = array('UserID' => LELONG_STORE_ID, 'Key' => LELONG_STORE_API_KEY, 'Product' => $productJson);
            $response = $this->curlReq->httpPost(LELONG_API_URL, $params);
            
            if($response != null){
                $jsonResponse = json_decode($response, true);
                $version = $jsonResponse['version'];
                $result = $jsonResponse['result'];
                $result_desc = $jsonResponse['resultdescription'];
                
                if($result != 0 && (empty($result) || $result == null || $result == '-1')){
                    $sync_status = 'ERROR1';
                    $this->UpdateQueueStatus($queue['queue_id'], 'F');
                    $this->_logger->writeLog('LelongQueue PushQueue : '.$productJson.'\nSync Failed.{Version : '.$version.', Description : '.$result_desc.'}'.json_encode($jsonResponse));
                }
                else{
                    $this->UpdateQueueStatus($queue['queue_id'], 'S');
                    $this->_logger->writeLog('LelongQueue PushQueue : '.$productJson.'\nSync Success.{Version : '.$version.', Description : '.$result_desc.'}');
                }
                
                $this->UpdateSyncLogResponse($logId, $response);
            }
            else{
                $this->UpdateQueueStatus($queue['queue_id'], 'P');
                $this->_logger->writeLog('LelongQueue PushQueue : '.$productJson.'\nSync Warning[Response Null]');
                
            }
        }
        $this->curlReq->close();
    }
}
?>
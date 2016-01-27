<?php
class Logger{
	private $_db;
	
	public function __construct($db = null){
		$this->_db = $db;
	}
	
    public function writeLog($logStr){
        
        
        try {
			$logDir = dirname(__FILE__).'/../log/';
						
            $fileName = $logDir.date('Y-m-d-H').'.log';
            $logFile = fopen($fileName, 'a');
            
            if (! $logFile) {
                throw new Exception("Could not open the file! File : ".$fileName);
            }
			chmod($fileName, 0666); 
            fwrite($logFile, date('Y-m-d H:i:s')." : ".$logStr."\r\n");
            fclose($logFile);
        }
        catch (Exception $e) {
            echo "Error (File: ".$e->getFile().", line ".
            $e->getLine()."): ".$e->getMessage();
        }
    }
	
	public function writeCronJobLog($logStr){
        try {
			$logDir = dirname(__FILE__).'/../log/cronjob/';
						
            $fileName = $logDir.date('Y-m-d-H').'.log';
            $logFile = fopen($fileName, 'a');
            
            if (! $logFile) {
                throw new Exception("Could not open the file! File : ".$fileName);
            }
            fwrite($logFile, date('Y-m-d H:i:s')." : ".$logStr."\r\n");
            fclose($logFile);
        }
        catch (Exception $e) {
            echo "Error (File: ".$e->getFile().", line ".
            $e->getLine()."): ".$e->getMessage();
        }
    }
	
	public function insertErrorLog($product_id, $message, $type){
		$queryStr = 'INSERT INTO '.DB_PREFIX.'lelong_error_log(log_type, product_id, message) VALUES ("'.$type.'", "'.$product_id.'", "'.$this->_db->escape($message).'")';
		
		$this->_db->query($queryStr);
	}
}
?>
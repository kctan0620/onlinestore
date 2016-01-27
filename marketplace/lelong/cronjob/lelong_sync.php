<?php
    @ini_set('display_errors', 1);
    include(dirname(__FILE__).'/../classes/lelong_config.php');
    include(dirname(__FILE__).'/../classes/lelong_queue.php');
    include(dirname(__FILE__).'/../classes/log.php');
	include(dirname(__FILE__).'/../../../system/library/db/mysqli.php');
    
    try{
		// Create connection
		$conn = new \DB\MySQLi(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);

		echo "Connected successfully<br />";
		
		$logger = new Logger($conn);
		$LelongQueue = new LelongSyncQueue($conn, $logger);
		$LelongQueue->ClearFailedQueue();
		$Queues = $LelongQueue->FetchQueue(18);
		$LelongQueue->Push($Queues);
		$conn = null;

    }
    catch(Exception $e) {
		echo 'TMT-CronJobExceptionMessage: ' .$e->getMessage();
    }
    
    
    
?>
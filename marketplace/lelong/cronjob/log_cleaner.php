<?php
    /************************************************************/
    /*********Cron Job to clean log file older than 7 days*******/
    /************************************************************/
    
    @ini_set('display_errors', 1);
	
	include(dirname(__FILE__).'/../classes/lelong_config.php');
	include(dirname(__FILE__).'/../../../system/library/db/mysqli.php');
	
    echo "Clean Log Files Job Start\r\n<br />";
    $days = 7;
    $durationInSeconds = $days * 24 * 60 * 60;
    $path = dirname(__FILE__).'/../log/';
	
	
    $filetypes_to_delete = array('log');

    if ($handle = opendir($path))
    {
		echo "Log Folder Opened\r\n<br />";
		
        while (false !== ($file = readdir($handle)))
        {
			echo "File Found : ".$path.$file."\r\n<br />";
			
            if (is_file($path.$file))
            {
				echo "Is File\r\n<br />";
				
                $file_info = pathinfo($path.$file);
                if (isset($file_info['extension']) && in_array(strtolower($file_info['extension']), $filetypes_to_delete))
                {
					echo "Is .log extension\r\n<br />";
                    if (filemtime($path.$file) < ( time() - ( $durationInSeconds ) ) )
                    {
                        unlink($path.$file);
                        echo "Deleted File : ".$path.$file."\r\n<br />";
                    }
                }
            }
        }
        
    }
	
	echo "Clean Log Files Job End\r\n<br />\r\n<br />";
	
	try{
		echo "Clean Log Database Records Job Start\r\n<br />";
		$conn = new \DB\MySQLi(DB_HOSTNAME, DB_USERNAME, DB_PASSWORD, DB_DATABASE, DB_PORT);

		echo "Databse Connected successfully\r\n<br />";
		
		
		$conn->query("DELETE FROM ".DB_PREFIX."lelong_sync_log WHERE DATEDIFF(NOW(), sync_date) > 14");
		echo "Cleaned Sync Log successfully\r\n<br />";
		
		$conn->query("DELETE FROM ".DB_PREFIX."lelong_error_log WHERE DATEDIFF(NOW(), create_time) > 14");
		echo "Cleaned Error Log successfully\r\n<br />";
		
		$conn->query("DELETE FROM ".DB_PREFIX."lelong_sync_queue WHERE DATEDIFF(NOW(), add_date) > 14");
		echo "Cleaned Sync Queue successfully\r\n<br />";
		
		$conn = null;
		
		echo "Clean Log Database Records Job End\r\n<br />";
    }
    catch(Exception $e) {
		echo 'TMT-CronJobExceptionMessage: ' .$e->getMessage();
    }
?>


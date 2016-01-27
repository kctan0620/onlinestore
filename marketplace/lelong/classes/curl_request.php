<?php
class curlReq{
    function curlReq(){
        $this->ch = curl_init();
    }
    
    function setLog($log){
        $this->log = $log;
    }
    
    function httpPost($url,$params,$type = 0)
    {
        $postData = '';
        //create name value pairs seperated by &
        foreach($params as $k => $v)
        {
			if(is_array($v)){
				$postData .= $k . '='.urlencode(json_encode($v)).'&';
			}
            else{
				$postData .= $k . '='.urlencode($v).'&';
			}
        }
        $postData = rtrim($postData, '&');
		
		if(strlen($postData) > 0){
			//$url .= "?".$postData;
		}
        curl_setopt($this->ch,CURLOPT_URL,$url);
        if($type == 0){
            curl_setopt($this->ch, CURLOPT_RETURNTRANSFER,true);
            curl_setopt($this->ch, CURLOPT_FOLLOWLOCATION,TRUE);
            curl_setopt($this->ch, CURLOPT_MAXREDIRS,1);//only 2 redirects
            curl_setopt($this->ch, CURLOPT_HEADER, false);
            curl_setopt($this->ch, CURLOPT_COOKIESESSION, true);
            curl_setopt($this->ch, CURLOPT_COOKIEJAR, '');  //could be empty, but cause problems on some hosts
            curl_setopt($this->ch, CURLOPT_COOKIEFILE, '');  //could be empty, but cause problems on some hosts
            curl_setopt($this->ch, CURLOPT_SSL_VERIFYPEER, false);
            curl_setopt($this->ch, CURLOPT_SSL_VERIFYHOST, false);
            curl_setopt($this->ch, CURLOPT_HTTPHEADER, array(
                                                         'Accept: application/json'
														 //'Content-Type: text/plain',                                                                                
														 //'Content-Length: ' . strlen($postData)
                                                         ));
            curl_setopt($this->ch, CURLOPT_USERAGENT,$this->getRandomUserAgent());
            curl_setopt($this->ch, CURLOPT_NOBODY, true);
            
        }

		curl_setopt($this->ch, CURLOPT_TIMEOUT,60);
		curl_setopt($this->ch, CURLOPT_CONNECTTIMEOUT,300);
		
        curl_setopt($this->ch, CURLOPT_POST, (strlen($postData) > 0)?true:false);
		curl_setopt($this->ch, CURLOPT_POSTFIELDS, $postData);
		
        if(($output=curl_exec($this->ch)) === false)
        {
            $this->log->writeLog('Error Params : '.$postData);
            $this->log->writeLog(curl_error($this->ch));
        }

        return $output;
        
    }
    
    function getRandomUserAgent()
    {
        $userAgents=array(
                          "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.8.1.6) Gecko/20070725 Firefox/2.0.0.6",
                          "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1)",
                          "Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30)",
                          "Opera/9.20 (Windows NT 6.0; U; en)",
                          "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; en) Opera 8.50",
                          "Mozilla/4.0 (compatible; MSIE 6.0; MSIE 5.5; Windows NT 5.1) Opera 7.02 [en]",
                          "Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; fr; rv:1.7) Gecko/20040624 Firefox/0.9",
                          "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/48 (like Gecko) Safari/48"
                          );
        $random = rand(0,count($userAgents)-1);
        
        return $userAgents[$random];
    }
    
    function close(){
        curl_close($this->ch);
    }
}
?>
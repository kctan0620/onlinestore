<?php
    require_once(dirname(__FILE__).'/../../../admin/config.php');
    define('LELONG_STORE_ID','tmtstore@1');
    define('LELONG_STORE_API_KEY', '9AF22FEA-7A83-4676-A4EF-716DC53EF862');
    define('LELONG_API_URL', 'https://members.lelong.com.my/Auc/Member/Feed/feed.asp');
    define('LELONG_STORE_CATEGORY_API_URL', 'https://members.lelong.com.my/Auc/Member/Feed/feed-server.asp');
	
	/** GST Type:
		Use the following code:

		1 = Standard-rated, item price include GST
		2 = Zero-rated, item price include GST
		3 = Exempted, item price include GST

		4 = Standard-rated, item price not include GST
		5 = Zero-rated, item price not include GST
		6 = Exempted, item price not include GST
	**/
	define('LELONG_PROD_GST_TYPE', '4');
	
	/** Ship Within Period
		This is optional. This sets you will ship the order within how many hours/days. Use the following code:

		1 = 24 business hours
		2 = 48 business hours
		3 = 1-3 days
		4 = 3-5 days
		5 = 5-7 days
		6 = 7-10 days
	**/
    define('LELONG_SHIP_WITHIN', '4');
    define('LELONG_PROD_STATE', 'Kuala Lumpur');
    define('LELONG_PROD_WHOPAY', 'BP');
    define('LELONG_PROD_SHIPTO', 'M');
    define('LELONG_PROD_SHIPPING_METHOD', 'P');
    define('LELONG_PROD_PAYMENT_METHOD', 'B,N,T,C');
    
    define('LELONG_SYN_QUEUE_TBL', 'lelong_sync_queue');
    define('LELONG_SYN_LOG_TBL', 'lelong_sync_log');
    define('LELONG_PRODUCT_TBL', 'lelong_product');
    define('LELONG_ERROR_LOG_TBL', 'lelong_error_log');
	
    define('LELONG_PROD_COVER', 'lelong_prod_cover');
    define('LELONG_PROD_GALLERY', 'lelong_prod_gallery');
	
	define('LELONG_ERROR_EMAIL_RECEIVER', 'jj.winer@gmail.com');
?>
<?php
// Init
$sql = array();

$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_sync_log';
$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_sync_queue';
$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_product';
$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_error_log';
$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_category';
$sql[] = 'DROP TABLE IF EXISTS '.DB_PREFIX.'lelong_store_category';
$sql[] = 'DELETE FROM '.DB_PREFIX.'setting WHERE code LIKE "lelong%"';

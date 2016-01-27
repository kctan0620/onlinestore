<?php
    require_once(dirname(__FILE__).'/log.php');
class ProductService{
    
    public function __construct($logger){
        $this->_logger = $logger;
        $this->db = Db::getInstance();
    }
    
    public function AddLelongProduct($productId, $productJson, $prodCombinations){
        $this->_logger->writeLog('ProductService->AddLelongProduct : '.$productJson);
        
        $queryStr = 'SELECT COUNT(product_id) AS TOTAL_PROD FROM '._DB_PREFIX_.LELONG_PRODUCT_TBL.' WHERE product_id = '.$productId;
        $this->_logger->writeLog('ProductService->AddLelongProductQuery : '.$queryStr);
        $row = $this->db->getRow($queryStr, false);
        
        if(!empty($row) && $row != null && $row['TOTAL_PROD'] > 0){
            $queryStr = 'UPDATE '._DB_PREFIX_.LELONG_PRODUCT_TBL.' SET product_json = "'.$this->db->_escape($productJson).'", options_json = "'.$this->db->_escape(json_encode($prodCombinations)).'", last_update = NOW() WHERE product_id = '.$productId;
            
            $this->_logger->writeLog('ProductService->AddLelongProductQuery $$ : '.$queryStr);
        }
        else{
            $queryStr = 'INSERT INTO '._DB_PREFIX_.LELONG_PRODUCT_TBL.' (product_id, product_json, options_json, last_update) VALUES ('.$productId.', "'.$this->db->_escape($productJson).'","'.$this->db->_escape(json_encode($prodCombinations)).'", NOW())';
            
            $this->_logger->writeLog('ProductService->AddLelongProductQuery $$^^ : '.$queryStr);
        }
        $this->_logger->writeLog('ProductService->AddLelongProductDone : '.$queryStr);
        $this->db->execute($queryStr);
    }
    
    public function FindLelongProduct($productId){
        $this->_logger->writeLog('ProductService->FindLelongProductJson : '.$productId);
        
        $queryStr = 'SELECT * FROM '._DB_PREFIX_.LELONG_PRODUCT_TBL.' WHERE product_id = '.$productId;
        $row = $this->db->getRow($queryStr, false);
        $this->_logger->writeLog('ProductService->FindLelongProductJsonQuery : '.$queryStr);
        return $row;
    }
}
    
?>
<?php
class ControllerToolMigrate extends Controller {
    public function index() {
		
	$this->load->model('catalog/product');
									
        $filter_data = array(
                'start'              => 0,
        		'limit'              => 2000
        );	

        //$number = 1;
        //$number = 2;
        //$number = 3;
        //$number = 4;
        //$number = 5;
        //$number = 6;
        //$number = 7;
        $number = 8;
        
        
		/* $results = $this->model_catalog_product->getProductsImage($filter_data);	
	
		$resultidimage = '';
		foreach ($results as $result) {
				
			$resultidimage = $result['id_image'];
				//split id_image
				$arr1 = str_split($resultidimage);
				$arr2 = str_split($resultidimage,2);
							
				$link = '';
				foreach($arr1 as $id){
					$com = array($id);  
				 // $com = $arr1
								
					$link .= $com[0] .'/';  
				 }
				$link .= $resultidimage; 				
			
				if (!file_exists('path/to/directory')) {
					mkdir('path/to/directory', 0777, true);
				}
			
				$newLink = 'http://www.tmt.my/onlinestore/img/p/'.$link.'-large_default.jpg';
				
				//Get the file
				$content = file_get_contents($newLink);
				
				$imath_path = DIR_IMAGE."/catalog/20150824/";
									
				if (!file_exists($imath_path)) {
					mkdir($imath_path, 0777, true);
				}
				//Store in the filesystem.
				$fp = fopen($imath_path.$resultidimage."-large_default.jpg", "w");
				fwrite($fp, $content);
				fclose($fp);
		} */        
        
       
        $results = $this->model_catalog_product->getLazadaProductsImage($filter_data, $number);
        
        //var_dump($results);
        //die();
        $resultidimage = '';
        foreach ($results as $result) {                	
        		
        	$newLink = $result['image'];
        
        	//Get the file

        		$content = file_get_contents($newLink);
        
	        	$imath_path = DIR_IMAGE."/catalog/201511028/";
	        		
	        	if (!file_exists($imath_path)) {
	        		mkdir($imath_path, 0777, true);
	        	}
	        	//Store in the filesystem.
	        	$fp = fopen($imath_path.$result['product_id']."-".$number.".jpg", "w");
	        	fwrite($fp, $content);
	        	fclose($fp);

        	        	
        }
        
        
		
		echo 'IMAGE MIGRATION DONE';
    }
	
	public function populateCategory()
	{
		$this->load->model('catalog/category');
		$this->model_catalog_category->populateCategoryPath();
		echo 'MIGRATE HAS DONE';
	}
} 



 


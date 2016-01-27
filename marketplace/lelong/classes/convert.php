<?php
    include_once('lelong_config.php');
    include_once('category.php');
    include_once('shipping.php');
    include_once('lelong_product.php');
	
    class Convert{
        private $productData;
		private $_logger;
		private $_db;
		
        public function __construct($logger = null, $db = null){
			$this->_db = $db;
            $this->categoryHelper = new CategoryHelper($db);
            $this->ShippingHelper = new ShippingHelper($db);
            $this->lelongProd = new LelongProduct();
			$this->_logger = $logger;
        }
        

        public function ToLelongProductJson($product_data, $lelong_product_data = null){
			$this->productData = $product_data;
			$this->_logger->insertErrorLog($product_id, 'ToLelongProductJson Step 1', 'DEBUG');
			$data['version'] = '1.0';
			$data['title'] = $product_data['product_description'][1]['name'];
			$data['guid'] = $product_data['product_id'];
			$data['price'] = $product_data['price'];
			
			$sales_price = $this->getProductSalePrice($product_data['product_discounts'], $product_data['product_specials']);
			
			$data['saleprice'] = ($sales_price != null)?$sales_price:$product_data['price'];
			
			$data['msrp'] = $product_data['price'];
			$data['costprice'] = '';
			$data['category'] = $this->getLelongCategory($product_data['product_categories']);
			$data['storecategory'] = $this->getLelongStoreCategory($product_data['product_categories']);
			$data['brand'] = (isset($product_data['manufacturer'])?$product_data['manufacturer']:"");
			$data['shipwithin'] = LELONG_SHIP_WITHIN;
			$data['modelskucode'] = $product_data['sku'];
			$data['state'] = LELONG_PROD_STATE;
			$data['link'] = $product_data['product_link'];
			$data['image'] = $product_data['image'];
			$data['image2'] = '';
			$data['image3'] = '';
			$data['image4'] = '';
			
			$img_count = 2;
			
			foreach($product_data['product_images'] as $product_image){
				$data['image'.$img_count] = $product_image['image'];
				
				if($img_count >= 4){
					break;
				}
				
				$img_count ++;
			}
		
			$description = $this->GetProductFeatures($product_data['product_attributes']).htmlspecialchars_decode($product_data['product_description'][1]['description']);
			$encodedDesc = preg_replace('/[^(\x20-\x7F)]*/', '', $description);
            $encodedDesc = utf8_encode($encodedDesc);
            $encodedDesc = str_replace("\r\n", "<br />", $encodedDesc);
            $encodedDesc = str_replace("\r", "<br />", $encodedDesc);
            $encodedDesc = str_replace("\n", "<br />", $encodedDesc);
            $encodedDesc = str_replace("<br \/>", "<br />", $encodedDesc);
            $encodedDesc = str_replace("\u00c2", "&nbsp;", $encodedDesc);
            $encodedDesc = str_replace("\u00a0", "&nbsp;", $encodedDesc);
            $encodedDesc = str_replace("u00c2", "&nbsp;", $encodedDesc);
            $encodedDesc = str_replace("u00a0", "&nbsp;", $encodedDesc);
			
			$data['description'] = $encodedDesc;
			$data['video'] = '';
			$data['videoalign'] = '';
			$data['publishdate'] = $product_data['date_available'];
			$this->_logger->insertErrorLog($product_id, 'ToLelongProductJson Step 2', 'DEBUG');
			/*********************************************************/
			/** The status of this product, use the following code: **/
			/** 0 = close item										**/
			/** 2 = hide item										**/
			/** 1 = add/edit										**/
			/*********************************************************/
			
			$status = intval($product_data['status']);
			if($status == 0){
				$status = 2;//Hide item status in Lelong
			}
			$data['active'] = $status;
			$data['weight'] = $product_data['weight'];
			$data['quantity'] = $product_data['quantity'];
			$data['shippingprice'] = $this->getLelongShippingPrice($product_data['product_categories']);
			$data['whopay'] = LELONG_PROD_WHOPAY;
			$data['shiptolocation'] = LELONG_PROD_SHIPTO;
			$data['shippingmethod'] = LELONG_PROD_SHIPPING_METHOD;
			$data['paymentmethod'] = LELONG_PROD_PAYMENT_METHOD;
			$data['gsttype'] = LELONG_PROD_GST_TYPE;
			$data['optionsstatus'] = '0';
			$this->_logger->insertErrorLog($product_id, 'ToLelongProductJson Step 3', 'DEBUG');		
			$options = $this->generateLelongProductOptions($product_data['product_options']);
			
			if($options != null && is_array($options) && count($options) > 0){
				$this->_logger->insertErrorLog($product_data['product_id'], 'Product Options : '.json_encode($options), 'DEBUG');
				
				$data['optionsstatus'] = '1';
				$data['options'] = $options;
				$data['optionsdetails'] = $this->generateLelongProductOptionsDetails($product_data['product_options'], 0, null, $data['price'], $data['saleprice']);
				
				$options_details_keys = array();
				
				if($data['optionsdetails'] != null){
					foreach($data['optionsdetails'] as $optiondetail){
						$options_details_keys[] = $optiondetail['sku'];
					}
				}
				
				if($lelong_product_data != null){
					$lelong_product = json_decode($lelong_product_data['product_json']);
					
					foreach($lelong_product->optionsdetails as $loptiondetail){
						if(!in_array($loptiondetail->sku, $options_details_keys)){
							$loptiondetail->status = 0;
							
							$data['optionsdetails'][] = get_object_vars($loptiondetail);
						}
					}
				}
			}
			$this->_logger->insertErrorLog($product_id, 'ToLelongProductJson Step 4', 'DEBUG');
			$hasError = false;
			
			$product_id = $product_data['product_id'];

			if($data['category'] == null || $data['category'] == ''){
				$hasError = true;
				$this->_logger->insertErrorLog($product_id, 'No category match. Please configure your website category to match with Lelong Category in Category Setting.', 'CONVERT_CONFIG');
			}
			
			if($data['storecategory'] == null || $data['storecategory'] == ''){
				$hasError = true;
				$this->_logger->insertErrorLog($product_id, 'No store category match. Please configure your website category to match with Lelong Store Category in Category Setting.', 'CONVERT_CONFIG');
			}
			
			if($data['shippingprice'] == null || $data['shippingprice'] == '' || $data['shippingprice'] == '^^^'){
				$hasError = true;
				$this->_logger->insertErrorLog($product_id, 'No shipping price match. Please configure the shipping price for each category related to this product in Category Setting.', 'CONVERT_CONFIG');
			}
			
			if($data['saleprice'] == null || empty($data['saleprice']) || doubleval($data['saleprice']) <= 0){
				$hasError = true;
				$this->_logger->insertErrorLog($product_id, 'Sale price is non-value or equal to zero. Please set the price to greater than 1.', 'CONVERT_CONFIG');
			}
			
			if($hasError == true){
				return null;
			}
			return $this->safe_json_encode($data);
		}
	
		private function getLelongCategory($categoriesData){
			
			$lelongCategoryId = null;
			
			foreach($categoriesData as $catagoryId){
				$lelongCategoryId = $this->categoryHelper->GetLelongCategory(strval($catagoryId));
				
				if($lelongCategoryId != null){
					break;
				}
				else{
					$this->_logger->insertErrorLog($this->productData['product_id'], 'Category Id ['.strval($catagoryId).'] does not configured in Lelong Product Sync Module','CONVERT_CONFIG');
				}
			}
			
            return ($lelongCategoryId != null)?$lelongCategoryId:'';
        }
        
        private function getLelongStoreCategory($categoriesData){

			$lelongCategoryId = null;
			
			foreach($categoriesData as $catagoryId){
				$lelongCategoryId = $this->categoryHelper->GetLelongStoreCategory($catagoryId);
				
				if($lelongCategoryId != null){
					break;
				}
				else{
					$this->_logger->insertErrorLog($this->productData['product_id'], 'Category Id ['.strval($catagoryId).'] does not configured in Lelong Product Sync Module','CONVERT_CONFIG');
				}
			}
			
            return ($lelongCategoryId != null)?$lelongCategoryId:'';
        }
		
		private function getLelongShippingPrice($categoriesData){

			$lelongShippingPrice = null;
			
			foreach($categoriesData as $catagoryId){
				$lelongShippingPrice = $this->ShippingHelper->GetLelongShippingPrice($catagoryId);
				
				if($lelongShippingPrice != null && $lelongShippingPrice != '' && $lelongShippingPrice != '^^^'){
					break;
				}
				else{
					$this->_logger->insertErrorLog($this->productData['product_id'], 'Category Id ['.strval($catagoryId).'] <b>SHIPPING PRICE</b> does not configured in Lelong Product Sync Module','CONVERT_CONFIG');
				}
			}
			
            return ($lelongShippingPrice != null)?$lelongShippingPrice:'';
        }
		
		private function generateLelongProductOptions($options_data){
			$this->_logger->insertErrorLog($product_data['product_id'], 'generateLelongProductOptions : '.json_encode($options_data), 'DEBUG');
			$options = array();
			$count = 1;
			foreach($options_data as $option_data){
				$this->_logger->insertErrorLog($product_data['product_id'], 'generateLelongProductOptions -> Loop : '.json_encode($option_data), 'DEBUG');
				$optionType = strtolower($option_data['type']);
				if($optionType == 'select' || $optionType == 'radio' || $optionType == 'image'){
					$this->_logger->insertErrorLog($product_data['product_id'], 'generateLelongProductOptions -> Valid Option Type : '.$option_data['product_option_id'], 'DEBUG');
					$option_id = $option_data['product_option_id'];
					$option_name = $this->getLelongOptionName($option_data['name']);
					
					$optionValuesData = $option_data['product_option_value'];
					$temp_option_values = array();
					foreach($optionValuesData as $optionValueData){
						$temp_option_values[] = $optionValueData['name'];
					}
					
					$key_1 = "optionName".$count;
					$key_2 = "optionDetail".$count;
					
					$temp_option_values_str = implode(",", $temp_option_values);
					
					$options[] = array($key_1 => $option_name, $key_2 => $temp_option_values_str);
					
					$count ++;				
				}
				else{
					$this->_logger->insertErrorLog($this->productData['product_id'], 'Product Option Id ['.strval($option_data['product_option_id']).'] option type does not allowed to be used in Lelong Product Sync Module. Only allowed option types(select, radio button, image).','CONVERT_CONFIG');
				}
			}
			
			return $options;
		}
		
		private function generateLelongProductOptionsDetails($optionsData, $index, $optionsDetails, $price, $sales_price){
			
			if($optionsData != null && is_array($optionsData)){
				$optionsDataCount = count($optionsData);
			
				if($optionsDetails == null){
					$optionsDetails = null;
					$count = 0;
					foreach($optionsData[$index]['product_option_value'] as $optionValueData){
						if(($index + 1) < $optionsDataCount){
							$nextOptionType = strtolower($optionsData[$index + 1]['type']);
							if($nextOptionType == 'select' || $nextOptionType == 'radio' || $nextOptionType == 'image'){
								foreach($optionsData[$index + 1]['product_option_value'] as $nextOptionValueData){
									$optionsDetails[$count]['id'] = $optionValueData['product_option_value_id'].' | '.$nextOptionValueData['product_option_value_id'];
									$optionsDetails[$count]['sku'] = $optionValueData['name'].' | '.$nextOptionValueData['name'];
									$optionsDetails[$count]['usersku'] = $optionValueData['name'].' '.$nextOptionValueData['name'];
									
									$optionPriceAddOn = doubleVal($optionValueData['price_prefix'].$optionValueData['price']) + doubleVal($nextOptionValueData['price_prefix'].$nextOptionValueData['price']);
									$optionsDetails[$count]['price'] = $optionPriceAddOn;
									$optionsDetails[$count]['saleprice'] = $optionPriceAddOn;
									
									$optionsDetails[$count]['quantity'] = (intval($optionValueData['quantity']) < intval($nextOptionValueData['quantity']))?intval($optionValueData['quantity']):intval($nextOptionValueData['quantity']);
									$optionsDetails[$count]['status'] = '1';
									$optionsDetails[$count]['warningqty'] = '0';
									
									/*$nextOptionValue = $this->getOptionValue($nextOptionValueData['option_value_id']);
									
									if($nextOptionValue != null && $nextOptionValue['image'] != null)
										$optionsDetails[$count]['image'] = $nextOptionValue['image'];*/
									
									
									$count ++;
								}
							}	
						}
						else{
							$optionType = strtolower($optionsData[$index]['type']);
							if($optionType == 'select' || $optionType == 'radio' || $optionType == 'image'){
								$optionsDetails[$count]['id'] = $optionValueData['product_option_value_id'];
								$optionsDetails[$count]['sku'] = $optionValueData['name'];
								$optionsDetails[$count]['usersku'] = $optionValueData['name'];
								
								$optionPriceAddOn = doubleVal($optionValueData['price_prefix'].$optionValueData['price']);
								$optionsDetails[$count]['price'] = $optionPriceAddOn;
								$optionsDetails[$count]['saleprice'] = $optionPriceAddOn;
								$optionsDetails[$count]['quantity'] = intVal($optionValueData['quantity']);
								$optionsDetails[$count]['status'] = '1';
								$optionsDetails[$count]['warningqty'] = '0';
								
								/*$optionValue = $this->getOptionValue($optionValueData['option_value_id']);
								
								if($optionValue != null && $optionValue['image'] != null)
									$optionsDetails[$count]['image'] = $optionValue['image'];*/
								
								$count ++;
							}
						}
					}
				}
				else if(is_array($optionsDetails) == true){
					$count = 0;
					
					foreach($optionsDetails as $optionDetails){
						if(($index + 1) < $optionsDataCount){
							
							foreach($optionsData[$index + 1]['product_option_value'] as $nextOptionValueData){
								$optionsDetails[$count]['id'] = $optionDetails['id'].' | '.$nextOptionValueData['product_option_value_id'];
								$optionsDetails[$count]['sku'] = $optionDetails['sku'].' | '.$nextOptionValueData['name'];
								$optionsDetails[$count]['usersku'] = $optionDetails['usersku'].' '.$nextOptionValueData['name'];
								
								$optionPriceAddOn = doubleVal($optionDetails['price']) + doubleVal($nextOptionValueData['price_prefix'].$nextOptionValueData['price']);
								
								$optionsDetails[$count]['price'] = $optionPriceAddOn;
								$optionsDetails[$count]['saleprice'] = $optionPriceAddOn;
								
								$optionsDetails[$count]['quantity'] = (intval($optionDetails['quantity']) < intval($nextOptionValueData['quantity']))?intval($optionDetails['quantity']):intval($nextOptionValueData['quantity']);
								$optionsDetails[$count]['status'] = '1';
								$optionsDetails[$count]['warningqty'] = '0';
								
								/*$optionValue = $this->getOptionValue($nextOptionValueData['option_value_id']);
								if($optionValue != null && $optionValue['image'] != null)
									$optionsDetails[$count]['image'] = $optionValue['image'];*/
								
								$count ++;
							}
						}
					}
				}
				
				if(($index + 1) < $optionsDataCount){
					return $optionsDetails = $this->generateLelongProductOptionsDetails($optionsData, $index + 1, $optionsDetails, $price, $sales_price);
				}
				
				return $optionsDetails;
			}
			return false;
		}
		
		private function getLelongOptionName($optionName){
			$optionName = strtolower($optionName);
			
			$lelongOptionName = $optionName;
			$lelongOptionName = "Others:".$optionName;
			
			switch($optionName){
				case 'color':
				case 'colors':
				case 'colour':
				case 'colours':
				case 'warna':
				case '颜色':
					$lelongOptionName = 'Color';
					break;
				case 'size':
				case 'sizes':
				case 'saiz':
				case '尺寸':
					$lelongOptionName = 'Size';
					break;
					
			}
			
			return $lelongOptionName;
		}
		
		public function getProductSalePrice($discounts, $specials){
			$salesPrice = null;
			
			if($specials != null && is_array($specials) && count($specials) > 0){
				foreach($specials as $special){
					$salesPrice = $special['price'];
					break;
				}
			}
			
			if($salesPrice == null){				
				if($discounts != null && is_array($discounts) && count($discounts) > 0){
					foreach($discounts as $discount){
						$salesPrice = $discount['price'];
						break;
					}
				}
			}
			
			return $salesPrice;
		}
		
		public function GetProductFeatures($product_attributes){
            $prodFeatureStr = '';
            
            if(count($product_attributes) > 0){
                $prodFeatureCache = array();
                
                $prodFeatureStr = '<table border="1" style="margin:0px auto;background-color:#FAFAFA;border-collapse:collapse;border:1px solid #CACACA;color:#000000;width:100%;max-width:800px;" cellpadding="5" cellspacing="3">';
                $prodFeatureStr .= '<tr><td colspan=2 align="center"><span style="font-size:24px;font-weight:bold;">Product Spefication</span></td></tr>';
                foreach($product_attributes as $product_attribute){
                    $key = $product_attribute['name'];
                    //if (!in_array($key, $product_attribute)){
                        $prodFeatureStr .= '<tr><td width="25%"><b>'.$product_attribute['name'].'</b></td><td width="77%">'.$product_attribute['product_attribute_description']['1']['text'].'</td></tr>';
                    //}
                    $prodFeatureCache[] = $key;
                    
                }
                $prodFeatureStr .= '</table>';
                $prodFeatureStr .= '<br />';
                $prodFeatureStr .= '<br />';
            }
            return $prodFeatureStr;
        }
		
        function safe_json_encode($mixed,$missing="TRANSLIT"){
            $out=json_encode($mixed, JSON_PRETTY_PRINT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE);
	
            if ($err = json_last_error()){
                iconv_r("UTF-8","UTF-8//$missing",$mixed);
                $out=json_encode($mixed, JSON_PRETTY_PRINT | JSON_HEX_AMP | JSON_UNESCAPED_UNICODE);
            }
			
            return $out;
        }
        
		function iconv_r($charset_i, $charset_o, &$mixed) {
            if (is_string($mixed)) {
                $mixed = iconv($charset_i, $charset_o, $mixed);
            } else {
                if (is_object($mixed)){
                    $mixed = (array) $mixed;
                }
                if (is_array($mixed)){
                    foreach ($mixed as $key => &$value) {
                        iconv_r($charset_i, $charset_o, $value);
                    }
                }
            }
        }
    }
    
?>
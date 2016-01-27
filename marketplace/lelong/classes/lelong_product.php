<?php
    
class LelongProduct{
    
    public $version = 1;
    public $title = '';
    public $guid = '';
    public $price = '';
    public $saleprice = '';
    public $msrp = '';
    public $costprice = '';
    public $category = '';
    public $storecategory = '';
    public $brand = '';
    public $shipwithin = '';
    public $modelskucode = '';
    public $state = '';
    public $link = '';
    public $image = '';
    public $image2 = '';
    public $image3 = '';
    public $image4 = '';
    public $description = '';
    public $publishdate = '';
    public $active = '';
    public $weight = '';
    public $quantity = '';
    public $shippingprice = '';
    public $whopay = '';
    public $shiptolocation = '';
    public $shippingmethod = '';
    public $paymentmethod = '';
    public $optionstatus = '';
    public $options = array();
    public $optionsdetails = array();
    
    public function addOption($option){
        $optCount = count($this->options);
        $optCount += 1;
        
        $formattedOpt = array();
        foreach($option as $key => $val){
            $formattedOpt[$key.$optCount] = $val;
        }
        
        $this->options[] = $formattedOpt;
    }
    
    public function addOptionDetail($optDetail){
        $this->optionsdetails[] = $optDetail;
    }
    
}

class LelongProductOption{
    public $optionName = '';
    public $optionDetail = '';
}

class LelongProductOptionDetails{
    public $sku = '';
    public $usersku = '';
    public $price = '';
    public $saleprice = '';
    public $msrp = '';
    public $costprice = '';
    public $quantity = '';
    public $warningqty = '';
    public $image1 = '';
    public $status = '';
    
}
?>
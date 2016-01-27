<?php echo $header; ?>
<?php 
	$event_intel_id = 173;
	$event_microsoft_id = 177;
	$event_gaming_id = 179;
	$event_wd_id = 194;
	$event_lu_id = 195;
	$event_12_id = 332;
	$event_projector_id = 333;
	$event_canon_id = 347;
	//$event_canon_id = 187;
	
	$event_laser_id = 0;
	$event_inject_id = 0;
	
	$event_bit_id = 354;
	$event_samsung_id = 346;
	$event_epson_id = 356;
	$event_razer_id = 337;
	
	$event_apple_id = 348;
	//$event_apple_id = 187;
	$event_xnew_id = 350; //xmas and new year
	$event_dec2015_timesale_id = 349; //xmas and new year	
	//$event_dec2015_timesale_id = 187; //xmas and new year
	
	$event_star_product_id = 351;
	$event_back_school_id = 352;
	$event_zoom_id = 353;
	
	$event_intel_christmas_id = 355;	
	$event_custompc_id = 358;
	$event_precious_id = 359;
	
?>
<!-- No product text will no appear if special category page -->
<?php $arr_event_category = array($event_intel_id,$event_microsoft_id,$event_gaming_id,$event_wd_id, $event_lu_id, $event_12_id, $event_projector_id, $event_canon_id, $event_bit_id,$event_samsung_id,$event_laser_id,$event_inject_id, $event_epson_id, $event_razer_id, $event_apple_id, $event_xnew_id, $event_dec2015_timesale_id, $event_star_product_id, $event_back_school_id, $event_zoom_id, $event_intel_christmas_id, $event_custompc_id, $event_precious_id);?>

<div id="container" class="container j-container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
      <h1 class="heading-title"><?php echo $heading_title; ?></h1>
      <?php echo $content_top; ?>
      <?php if ($thumb || $description) { ?>
      <div class="category-info">
        <?php if ($thumb) { ?>
        <div class="image"><img width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
        <?php } ?>
        <?php if ($description) { ?>
        <?php echo $description; ?>
        <?php } ?>
      </div>
      <?php } ?>
                  
      <?php if($this->journal2->settings->get('refine_category') === 'grid'): ?>
      <div class="refine-images">
        <?php foreach ($this->journal2->settings->get('refine_category_images', array()) as $category): ?>
        <div class="refine-image <?php echo Journal2Utils::getProductGridClasses($this->journal2->settings->get('refine_category_images_per_row'), $this->journal2->settings->get('site_width', 1024), $this->journal2->settings->get('config_columns_count')); ?>">
          <a href="<?php echo $category['href']; ?>"><img style="display: block" width="<?php echo $this->journal2->settings->get('refine_image_width', 175); ?>" height="<?php echo $this->journal2->settings->get('refine_image_height', 175); ?>" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/><span class="refine-category-name"><?php echo $category['name']; ?></span></a>
        </div>
        <?php endforeach; ?>
        <script>
          Journal.equalHeight($(".refine-images .refine-image"), '.refine-category-name');
        </script>
      </div>
      <?php endif; ?>
      <?php if($this->journal2->settings->get('refine_category') === 'carousel'): ?>
      
       <?php if(!in_array($this->request->get['path'], $arr_event_category)): ?>
      <div id="refine-images" class="owl-carousel">
        <?php foreach ($this->journal2->settings->get('refine_category_images', array()) as $category): ?>
        <div class="refine-image">
          <a href="<?php echo $category['href']; ?>"><img style="display: block" width="<?php echo $this->journal2->settings->get('refine_image_width', 175); ?>" height="<?php echo $this->journal2->settings->get('refine_image_height', 175); ?>" src="<?php echo $category['thumb']; ?>" alt="<?php echo $category['name']; ?>"/><span class="refine-category-name"><?php echo $category['name']; ?></span></a>
        </div>
        <?php endforeach; ?>
      </div>
      <?php endif;?>
      
      <?php
        $grid = Journal2Utils::getItemGrid($this->journal2->settings->get('refine_category_images_per_row'), $this->journal2->settings->get('site_width', 1024), $this->journal2->settings->get('config_columns_count'));
      $grid = array(
      array(0, (int)$grid['xs']),
      array(470, (int)$grid['sm']),
      array(760, (int)$grid['md']),
      array(980, (int)$grid['lg']),
      array(1100, (int)$grid['xl'])
      );
      ?>
      <script>
        (function () {
          var opts = $.parseJSON('<?php echo json_encode($grid); ?>');
          jQuery("#refine-images").owlCarousel({
            itemsCustom:opts,
            autoPlay: <?php echo $this->journal2->settings->get('refine_carousel_autoplay') ? '4000' : 'false' ; ?>,
          touchDrag: <?php echo $this->journal2->settings->get('refine_carousel_touchdrag') ? 'true' : 'false' ; ?>,
          stopOnHover: <?php echo $this->journal2->settings->get('refine_carousel_pause_on_hover') ? 'true' : 'false'; ?>,
          navigation:true,
                  scrollPerPage:true,
                  navigationText : false,
                  paginationSpeed:400,
                  margin:13
        });
        Journal.equalHeight($("#refine-images .refine-image"), '.refine-category-name');
        })();
      </script>
      <?php endif; ?>
      <?php if($this->journal2->settings->get('refine_category') === 'text'): ?>
      <?php if ($categories) { ?>
      <h2 class="refine"><?php echo $text_refine; ?></h2>
      <div class="category-list">
        <ul>
          <?php foreach ($categories as $category) { ?>
          <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
      <?php } ?>
      <?php endif; ?>
      
      
      
      
      <?php if(isset($event_description) && !empty($event_description)): ?>      
      	
      <!-- Top Banner -->      
      		<?php echo html_entity_decode($event_page['main_banner'])?>                  
      
      <?php 
      		$i = 0;
      		foreach ($event_description as $description) :
      ?>      		
      		
      		<h2 class="secondary-title"><a href="<?php isset($description['event_url']) ? $description['event_url'] : '' ?>"><b style="font-size:25px"><?php echo $description['event_name']?></b></a> </h2>     		
      		<a href="<?php echo !empty($description['event_url']) ? $description['event_url'] : '' ?>"><?php echo html_entity_decode($description['event_description'])?></a>                  
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      
      		
      <?php 			
      				foreach($product_group[$i] as $product){
      ?>
      
      	<div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
	          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
	            <div class="image">
	              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
	                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
	              </a>
	              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
	              <?php foreach ($product['labels'] as $label => $name): ?>
	              <?php if ($label === 'outofstock'): ?>
	              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
	              <?php else: ?>
	              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
	              <?php endif; ?>
	              <?php endforeach; ?>
	              <?php endif; ?>
	              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
	                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
	                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
	              <?php endif; ?>
	            </div>
	            <div class="product-details">
	              <div class="caption">
	                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
	                <p class="description"><?php echo $product['description']; ?></p>
	                <?php if ($product['rating']) { ?>
	                <div class="rating">
	                  <?php for ($i = 1; $i <= 5; $i++) { ?>
	                  <?php if ($product['rating'] < $i) { ?>
	                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
	                  <?php } else { ?>
	                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
	                  <?php } ?>
	                  <?php } ?>
	                </div>
	                <?php } ?>
	                <?php if ($product['price']) { ?>
	                <p class="price">
	                  <?php if (!$product['special']) { ?>
	                  <?php echo $product['price']; ?>
	                  <?php } else { ?>
	                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
	                  <?php } ?>
	                  <?php if ($product['tax']) { ?>
	                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
	                  <?php } ?>
	                </p>
	                <?php } ?>
	              </div>
	              <div class="button-group">
	                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
	                <div class="cart enquiry-button">
	                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
	                </div>
	                <?php else: ?>
	                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
	                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
	                </div>
	                <?php endif; ?>
	                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
	                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
	              </div>
	            </div>
	          </div>
	        </div>
      	
      <?php 
      				}      			
      ?>
      		</div>
      <?php 		
      			$i++;
      			endforeach;
      ?>			
      		
      <?php 
      		endif;
      ?>
      
   
      
      <!-- This is Intel Page ID -->
      <?php if($this->request->get['path'] == $event_intel_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/main_banner (windows_10 and_Intel).jpg" width="100%" height="auto">
      		
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=174"><b style="font-size:25px">2-in-1</b></a>
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=174"><img src="http://www.tmt.my/onlinestore/image/2_in_1_landing.jpg" width="100%" height="auto"></a>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_group1) { ?>
      			
      			<?php foreach ($products_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=176"><b style="font-size:25px">Notebook</b></a>
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=176"><img src="http://www.tmt.my/onlinestore/image/laptop_landing.jpg" width="100%" height="auto"></a>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_group2) { ?>
      			
      			<?php foreach ($products_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=175"><b style="font-size:25px">All in one</b></a>
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=175"><img src="http://www.tmt.my/onlinestore/image/all-in-ones_landing.jpg" width="100%" height="auto"></a>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_group3) { ?>
      			
      			<?php foreach ($products_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
      <!-- This is End of Intel Page ID -->
      
      <!-- This is Microsoft Page ID -->
      <?php if($this->request->get['path'] == $event_microsoft_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Microsoft%20Main%20Banner.jpg" width="100%" height="auto">
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=177"><b style="font-size:25px">Microsoft Surface Pro 4</b></a>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Surface%20Pro%204%20Banner.jpg" width="100%" height="auto">
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_microsoft_group1) { ?>
      			
      			<?php foreach ($products_microsoft_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=177"><b style="font-size:25px">Microsoft Surface Pro 3</b></a>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Surface%20Pro%203%20Banner.jpg" width="100%" height="auto">
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_microsoft_group2) { ?>
      			
      			<?php foreach ($products_microsoft_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=177"><b style="font-size:25px">Type Cover Surface</b></a>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Type%20cover.jpg" width="100%" height="auto">
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_microsoft_group3) { ?>
      			
      			<?php foreach ($products_microsoft_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Microsoft Page ID -->
	  
	  <!-- This is Gaming Page ID -->
      <?php if($this->request->get['path'] == $event_gaming_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Gaming%20main%20banner%20event.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 1</span>  <a href="#"><b style="font-size:20px">DOTA 2</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_gaming_group1) { ?>
      			
      			<?php foreach ($products_gaming_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 2</span><a href="#"><b style="font-size:20px">GAME CODE</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_gaming_group2) { ?>
      			
      			<?php foreach ($products_gaming_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 3</span><a href="#"><b style="font-size:20px">TOS & CARD GAME</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_gaming_group3) { ?>
      			
      			<?php foreach ($products_gaming_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		
      		<h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 4</span><a href="#"><b style="font-size:20px">GAMING PC & LAPTOP</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_gaming_group4) { ?>
      			
      			<?php foreach ($products_gaming_group4 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		 
      		<h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 5</span><a href="#"><b style="font-size:20px">GAMING KEYBOARD & MOUSE</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_gaming_group5) { ?>
      			
      			<?php foreach ($products_gaming_group5 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>      		      		
      		
      <?php endif;?>
	  <!-- This is End of Microsoft Page ID -->
	  
	  <!-- This is WD Page ID -->
      <?php if($this->request->get['path'] == $event_wd_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/Banner/WD Top Banner 2.jpg" width="100%" height="auto"-->      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Cat-my%20cliud%20mirror.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="#"><b style="font-size:20px">WD My Cloud Mirror Series</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_wd_group1) { ?>
      			
      			<?php foreach ($products_wd_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Cat-my cloud.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="#"><b style="font-size:20px">WD My Cloud Series</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_wd_group2) { ?>
      			
      			<?php foreach ($products_wd_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Cat-wireless.jpg" width="100%" height="auto">      		
      		<h2 class="secondary-title"><a href="#"><b style="font-size:20px">WD My Passport Wireless</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_wd_group3) { ?>
      			
      			<?php foreach ($products_wd_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Cat-Portable.jpg" width="100%" height="auto">      		      		
      		<h2 class="secondary-title"><a href="#"><b style="font-size:20px">WD Portable Storage</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_wd_group4) { ?>
      			
      			<?php foreach ($products_wd_group4 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="#"><b style="font-size:20px">WD Others</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_wd_group5) { ?>
      			
      			<?php foreach ($products_wd_group5 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of WD Page ID -->
	  
	  <!-- This is Like and Unlock Page ID -->
      <?php if($this->request->get['path'] == $event_lu_id): ?>
      		<a href="https://www.facebook.com/TMT.Online.Mall/?fref=ts&ref=br_tf" target="_blank"><img src="http://www.tmt.my/onlinestore/image/Banner/like_unlock_banner.jpg" width="100%" height="auto"></a>
      		</br></br>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/likes_unlock_second_banner.jpg" width="100%" height="auto">
      		</br></br>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Term%20&%20Conditions.jpg" width="100%" height="auto">
      		<!--h2 class="secondary-title"><span style="color:navy;padding-right:5px;">FLOOR 1</span>  <a href="#"><b style="font-size:20px">DOTA 2</b></a></h2-->      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_lu_group1) { ?>
      			
      			<?php foreach ($products_lu_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <!--div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div-->
				                <?php else: ?>
				                <!--div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div-->
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		
      		
      		
      		
      <?php endif;?>
	  <!-- This is End of Like and Unlock Page ID -->
	  
	  
	 <!-- This is Crazy 12.12 Page ID -->
      <?php if($this->request->get['path'] == $event_12_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Top%20Banner%201212.jpg" width="100%" height="auto">
      		</br></br>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Crazy Corner1212.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/crazy1212"><b style="font-size:20px">Crazy Corner</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_12_group1) { ?>
      			
      			<?php foreach ($products_12_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Pc%20&%20Lap%20Top1212.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/crazy1212"><b style="font-size:20px">PC & Laptop</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_12_group2) { ?>
      			
      			<?php foreach ($products_12_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>

      		<img src="http://www.tmt.my/onlinestore/image/Banner/Mobile%20&%20tablet%201212.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/crazy1212"><b style="font-size:20px">Mobile & Tablet</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_12_group3) { ?>
      			
      			<?php foreach ($products_12_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Crazy 1212 Page ID -->
	  
	  <!-- This is Projector Page ID -->
      <?php if($this->request->get['path'] == $event_projector_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Epson%20banner.jpg" width="100%" height="auto">      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">EPSON</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_projector_group1) { ?>
      			
      			<?php foreach ($products_projector_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Sony%20Banner%202.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">SONY</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_projector_group2) { ?>
      			
      			<?php foreach ($products_projector_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>

      		<img src="http://www.tmt.my/onlinestore/image/Banner/NEC%20Banner.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">NEC</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_projector_group3) { ?>
      			
      			<?php foreach ($products_projector_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Projector Page ID -->
	  
	  <!-- This is Canon Page ID -->
      <?php if($this->request->get['path'] == $event_canon_id): ?>
      	</br></br>
        <div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		&nbsp;
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		<a href="#"><img src="http://www.tmt.my/onlinestore/image/Banner/logo_canon.png" width="100%"></a>
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		&nbsp;
				   </div>				   				   
				   				 				   				   
      	</div>    
            
             	
      	<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      		
      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Main Banner Canon Event.jpg" width="100%" height="auto">      		
      		</div>      		      		      		
      		<!--div class="xs-100 sm-100 md-100 lg-100 xl-100">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Sony%20Banner%202.jpg" width="100%" height="auto">
      		</div>
      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/NEC%20Banner.jpg" width="100%" height="auto">
      		</div-->
 		</div>    
 		
 		</br>
 		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		<a href="#"><img src="http://www.tmt.my/onlinestore/image/Banner/Laser jack Printer banner 2.jpg" width="100%"></a>
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		<a href="#"><img src="http://www.tmt.my/onlinestore/image/Banner/Inject Printer banner 2.jpg" width="100%"></a>
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-33 xl-33">
				   		<a href="#"><img src="http://www.tmt.my/onlinestore/image/Banner/INk & Toner Printer banner 2.jpg" width="100%"></a>
				   </div>				   				   
				   				 				   				   
      	</div>
      		
      	</br></br>	
      	<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/canon"><b style="font-size:20px"> Ink Toner </b></a></h2>      		      			
      	<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">      		
      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Banner 2 t.jpg" width="100%" height="auto">      		
      		</div>      		      		      		      		
 		</div>   	
      		 		
      		<!--div class="product-list-item">
	      		<div class="xs-100 sm-100 md-66 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg">
	      		</div>
	      		<div class="xs-100 sm-100 md-66 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg">
	      		</div>
	      		<div class="xs-100 sm-100 md-66 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg">
	      		</div>
	      		<div class="xs-100 sm-100 md-66 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg">
	      		</div>
      		</div-->
      		
      		<!--div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
				   
				   <div class="xs-100 sm-100 md-66 lg-25 xl-25">
				   		<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg" width="100%">
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-25 xl-25">
				   		<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg" width="100%">
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-25 xl-25">
				   		<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg" width="100%">
				   </div>
				   
				   <div class="xs-100 sm-100 md-66 lg-25 xl-25">
				   		<img src="http://www.tmt.my/onlinestore/image/Banner/sample.jpg" width="100%">
				   </div>
				   				 				   				   
      		</div-->
      		

      		<!--div class="owl-wrapper" style="width: 100%; left: 0px; display: block; transition: all 0ms ease; transform: translate3d(0px, 0px, 0px);">
      				<div class="owl-item" style="width: 100%;">
	      				<div class="static-banner ">
	                    <a href="#"> <span class="banner-overlay" style=";  background-color: rgba(235, 88, 88, 0.4) "><i style="margin-right: 5px; color: rgb(255, 255, 255); font-size: 30px" data-icon="«×"></i></span><img style="" src="http://localhost/onlinestore/image/cache/data/journal2/misc/sample-360x140.jpg" width="360" height="140" alt=""></a>
	                    </div>
                    </div>
                    
                    
                    <div class="owl-item" style="width: 335px;">
	                    <div class="static-banner ">
	                        <a href="#"> <span class="banner-overlay" style=";  background-color: rgba(235, 88, 88, 0.4) "><i style="margin-right: 5px; color: rgb(255, 255, 255); font-size: 30px" data-icon="«×"></i></span><img style="" src="http://localhost/onlinestore/image/cache/data/journal2/misc/sample-360x140.jpg" width="360" height="140" alt=""></a>
	                    </div>
                    </div>
                    
                    
                    <div class="owl-item" style="width: 335px;"><div class="static-banner ">
                        <a href="#"> <span class="banner-overlay" style=";  background-color: rgba(235, 88, 88, 0.4) "><i style="margin-right: 5px; color: rgb(255, 255, 255); font-size: 30px" data-icon="«×"></i></span><img style="" src="http://localhost/onlinestore/image/cache/data/journal2/misc/sample-360x140.jpg" width="360" height="140" alt=""></a>
                    </div></div><div class="owl-item" style="width: 335px;"><div class="static-banner ">
                        <img style="" src="http://localhost/onlinestore/image/cache/Banner/sample-360x140.jpg" alt="" width="360" height="140">
               </div></div>
           </div-->

      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_canon_group1) { ?>
      			
      			<?php foreach ($products_canon_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		
      		
      <?php endif;?>
	  <!-- This is End of Canon Page ID -->
	  
	  <!-- This is Bit Defender Page ID -->
      <?php if($this->request->get['path'] == $event_bit_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/Banner/Top Banner Bitfender Promotion.jpg" width="100%" height="auto"-->      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Bitdefender</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_bit_group1) { ?>
      			
      			<?php foreach ($products_bit_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>

      		
      <?php endif;?>
	  <!-- This is End of Bit Defender Page ID -->
	  
	  
	  <!-- This is Samsung Page ID -->
      <?php if($this->request->get['path'] == $event_samsung_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/TopBannerSamsung.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/samsung"><b style="font-size:20px">Samsung Original Accessories</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_samsung_group1) { ?>
      			
      			<?php foreach ($products_samsung_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Samsung Page ID -->
	  
	  <!-- This is Epson Page ID -->
      <?php if($this->request->get['path'] == $event_epson_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/TopBannerEpson.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/epson"><b style="font-size:20px">Epson</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_epson_group1) { ?>
      			
      			<?php foreach ($products_epson_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Epson Page ID -->
	  
	  
	  <!-- This is Razer Page ID -->
      <?php if($this->request->get['path'] == $event_razer_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Top-Banner-Razer.gif" width="100%" height="auto">      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/razer"><b style="font-size:20px">Keyboard</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_razer_group1) { ?>
      			
      			<?php foreach ($products_razer_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/razer"><b style="font-size:20px">Mouse</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_razer_group2) { ?>
      			
      			<?php foreach ($products_razer_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>

      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/razer"><b style="font-size:20px">Mouse pad</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_razer_group3) { ?>
      			
      			<?php foreach ($products_razer_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/razer"><b style="font-size:20px">Headset</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_razer_group4) { ?>
      			
      			<?php foreach ($products_razer_group4 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/razer"><b style="font-size:20px">Acessories</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_razer_group5) { ?>
      			
      			<?php foreach ($products_razer_group5 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Razer Page ID -->

      
      <!-- This is Customized PC Page ID -->
      <?php if($this->request->get['path'] == $event_custompc_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Top banner customize & make it your way.jpg" width="100%" height="auto">
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/customizemakeityourway"><b style="font-size:20px">Customized PC</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_custompc_group1) { ?>
      			
      			<?php foreach ($products_custompc_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Custom Pc Page ID -->
      
      <!-- This is Apple Page ID -->
      <?php if($this->request->get['path'] == $event_apple_id): ?>
      		
        <img src="http://www.tmt.my/onlinestore/image/Banner/Top Banner 984px x 332 px.jpg" width="100%" height="auto">
      	
      	</br></br>
      	
      	<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Main Images Mac.jpg" width="100%" height="auto">      		
      		</div>      		      		      		
      		
      		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/1 Macbook  151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/2 Macbook Air 151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/3 Macbook Pro 151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
	      		
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/4 iMac 151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/5 Mac Pro 151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
	      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      			<img src="http://www.tmt.my/onlinestore/image/Banner/6 Mac Mini 151pxX244 px.jpg" width="100%" height="auto">
	      		</div>
      		</div>
      		
 		</div>
 		
 		</br>
 		
 		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Main images iPhone.jpg" width="100%" height="auto">      		
      		</div>  
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/1 iPhone 6S 151pxX244 px.jpg" width="100%" height="auto">      		
      		</div>  
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/2 iPhone 6 151pxX244 px.jpg" width="100%" height="auto">      		
      		</div>  
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/3 iPhone 5s 151pxX244 px.jpg" width="100%" height="auto">      		
      		</div>      		      		      		
	
 		</div>
 		
 		</br>
 		
 		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Main Images Ipad.jpg" width="100%" height="auto">      		
      		</div>      		      		      		
      		
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
		      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
		      			<img src="http://www.tmt.my/onlinestore/image/Banner/1 iPad Air 151pxX244 px.jpg" width="100%" height="auto">
		      		</div>
		      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
		      			<img src="http://www.tmt.my/onlinestore/image/Banner/2 iPad Air 2  151pxX244 px.jpg" width="100%" height="auto">
		      		</div>		      		
	      		</div>
      		</div>
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
	      		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
		      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
		      			<img src="http://www.tmt.my/onlinestore/image/Banner/3 iPad Mini 2 151pxX244 px.jpg" width="100%" height="auto">
		      		</div>
		      		<div class="xs-100 sm-100 md-100 lg-100 xl-100">
		      			<img src="http://www.tmt.my/onlinestore/image/Banner/4 iPad Mini 4 151pxX244 px.jpg" width="100%" height="auto">
		      		</div>	      		
	      		</div>
      		</div>
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/5 Ipad Pro.jpg" width="100%" height="auto">      		
      		</div> 
      		
 		</div>
 		
 		</br>
 		
 		<img src="http://www.tmt.my/onlinestore/image/Banner/Watch 984 px X 304 px.jpg" width="100%" height="auto">
 		
 		</br></br>
 		
 		<div class="row" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">      		
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/Main images Accessories.jpg" width="100%" height="auto">      		
      		</div>   
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/1 Accessories Mac.jpg" width="100%" height="auto">      		
      		</div>  
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/2 Accessories iPad.jpg" width="100%" height="auto">      		
      		</div>  
      		
      		<div class="xs-100 sm-100 md-100 lg-25 xl-25">
      			<img src="http://www.tmt.my/onlinestore/image/Banner/3 Accessories iPhone.jpg" width="100%" height="auto">      		
      		</div>  
 		</div>	
 		
      	</br>	
      		
      	<img src="http://www.tmt.my/onlinestore/image/Banner/TV 984 px X 304 px.jpg" width="100%" height="auto">		      			      	
      		
      <?php endif;?>
	  <!-- This is End of Apple Page ID -->
	  
	  
	  <!-- This is Xmas and New Year Page ID -->
      <?php if($this->request->get['path'] == $event_xnew_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Event-Top-Banner.gif" width="100%" height="auto">
      		</br>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/For all.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/xmasandnewyearspecial"><b style="font-size:20px">Special Gift To All</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_xnew_group1) { ?>
      			
      			<?php foreach ($products_xnew_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<img src="http://www.tmt.my/onlinestore/image/Banner/For Him.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/xmasandnewyearspecial"><b style="font-size:20px">For Him (21-27 Dec)</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_xnew_group2) { ?>
      			
      			<?php foreach ($products_xnew_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>

      		<img src="http://www.tmt.my/onlinestore/image/Banner/For her.jpg" width="100%" height="auto">
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/xmasandnewyearspecial"><b style="font-size:20px">For Her (21-27 Dec)</b></a></h2>
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_xnew_group3) { ?>
      			
      			<?php foreach ($products_xnew_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              		  <?php 
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      <?php endif;?>
	  <!-- This is End of Xmas and New Year Page ID -->
	  	  
	  <!-- This is DEC - Time Sales Page ID -->
      <?php if($this->request->get['path'] == $event_dec2015_timesale_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Top banner time sale (1).jpg" width="100%" height="auto">      		      		      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Monday - 21-12-2015</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group1) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982,3996,4027,4028,4029,4030,3985,4031,4083,3989,4032,4033,3987,4034,4035,4028, 4037,4059,3988,4039,4040,4028,4041,4042,3990,4043,4044,4028,4045,4085,4060);
						              		$arr_product_timesale = array(3996,4027,4028,4029,4030,3985,4031,4083,3989,4032,4033,3987,4034,4035,4028, 4037,4059,3988,4039,4040,4028,4041,4042,3990,4043,4044,4028,4045,4085,4060);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />

						              <?php elseif(in_array($product['product_id'], $arr_product_timesale)): ?>
						              				
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Tuesday - 22-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group2) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		
						              
						              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="">
						              
						             
				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Wednesday - 23-12-2015 </b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group3) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Thursday - 24-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group4) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group4 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Friday - 25-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group5) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group5 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Monday - 28-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group6) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group6 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
						             <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Tuesday - 29-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group7) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group7 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              				              				
				              		  		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Wednesday - 30-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group8) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group8 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
				              		  		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Thursday - 31-12-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group9) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group9 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>			              
				              		  	<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Friday - 1-1-2015</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_dec2015_timesale_group10) { ?>
      			
      			<?php foreach ($products_dec2015_timesale_group10 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
				              		  		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		      		
      <?php endif;?>
	  <!-- This is End of Xmas and New Year Page ID -->
      
      <!-- This is Star Product Page ID -->
      <?php if($this->request->get['path'] == $event_star_product_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/Banner/Epson%20banner.jpg" width="100%" height="auto"-->      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Star Product</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_star_product_group1) { ?>
      			
      			<?php foreach ($products_star_product_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
  		
      <?php endif;?>
	  <!-- This is End of Star Product Page ID -->
	  
	  <!-- This is Back to school Page ID -->
      <?php if($this->request->get['path'] == $event_back_school_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/Banner/Epson%20banner.jpg" width="100%" height="auto"-->      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Back to school</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_back_school_group1) { ?>
      			
      			<?php foreach ($products_back_school_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
  		
      <?php endif;?>
	  <!-- This is End of Back School Page ID -->
	  
	  <!-- This is Zoom in Page ID -->
      <?php if($this->request->get['path'] == $event_zoom_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/Banner/Epson%20banner.jpg" width="100%" height="auto"-->      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/projector"><b style="font-size:20px">Zoom in & Zoom Out</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_zoom_group1) { ?>
      			
      			<?php foreach ($products_zoom_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
  		
      <?php endif;?>
	  <!-- This is End of Zoom in Page ID -->
	  
	  <!-- This is Intel December Christmas Special Page ID -->
      <?php if($this->request->get['path'] == $event_intel_christmas_id): ?>
      		<!--img src="http://www.tmt.my/onlinestore/image/main_banner (windows_10 and_Intel).jpg" width="100%" height="auto"-->
      		
      		<!--a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=174"><b style="font-size:25px">December Christmas Special</b></a-->
      		<!--a href="http://www.tmt.my/onlinestore/index.php?route=product/category&path=174"><img src="http://www.tmt.my/onlinestore/image/2_in_1_landing.jpg" width="100%" height="auto"></a-->
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_intel_christmas_group1) { ?>
      			
      			<?php foreach ($products_intel_christmas_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>      		
      		
      <?php endif;?>
      <!-- This is End of Intel December Christmas Special Page ID -->
      
      <!-- This is Precious Memory Page ID -->
      <?php if($this->request->get['path'] == $event_precious_id): ?>
      		<img src="http://www.tmt.my/onlinestore/image/Banner/Top banner precious memory.jpg" width="100%" height="auto">      		      		      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">iOS Pendrive</b></a></h2>      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group1) { ?>
      			
      			<?php foreach ($products_precious_group1 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <?php 
						              	
						              		$arr_product = array(3979,3980,3981,3984,3982,3996,4027,4028,4029,4030,3985,4031,4083,3989,4032,4033,3987,4034,4035,4028, 4037,4059,3988,4039,4040,4028,4041,4042,3990,4043,4044,4028,4045,4085,4060);
						              		$arr_product_timesale = array(3996,4027,4028,4029,4030,3985,4031,4083,3989,4032,4033,3987,4034,4035,4028, 4037,4059,3988,4039,4040,4028,4041,4042,3990,4043,4044,4028,4045,4085,4060);
						              		if(in_array($product['product_id'], $arr_product)): 				              
						              ?>
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />

						              <?php elseif(in_array($product['product_id'], $arr_product_timesale)): ?>
						              				
						              <?php 
						              		else:
						              ?>
						              
						              <!--img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" /-->
						              
						              <?php 		
						              		endif;
						              ?>
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>				                  
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">Memory Card (Micro SD)</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group2) { ?>
      			
      			<?php foreach ($products_precious_group2 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              
				              		
						              
						              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="">
						              
						             
				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">Pendrive</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group3) { ?>
      			
      			<?php foreach ($products_precious_group3 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
				              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
				                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
				                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
				                </div>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">Camera SDHC</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group4) { ?>
      			
      			<?php foreach ($products_precious_group4 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
						              		<img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">External Harddisk</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group5) { ?>
      			
      			<?php foreach ($products_precious_group5 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>
						              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
      		
      		<h2 class="secondary-title"><a href="http://www.tmt.my/onlinestore/saveyourpreciousmemory"><b style="font-size:20px">Internal Harddisk</b></a></h2>
      		
      		<div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
      			<?php if($products_precious_group6) { ?>
      			
      			<?php foreach ($products_precious_group6 as $product) : ?>
				        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
				          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
				            <div class="image">
				              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
				                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
				              </a>
				              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
				              <?php foreach ($product['labels'] as $label => $name): ?>
				              <?php if ($label === 'outofstock'): ?>				              
						             <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />						              				              
				              <?php else: ?>
				              <b><?php echo $name; ?></b>
				              <?php endif; ?>
				              <?php endforeach; ?>
				              <?php endif; ?>
				              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
				                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              <?php endif; ?>
				            </div>
				            <div class="product-details">
				              <div class="caption">
				                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
				                <p class="description"><?php echo $product['description']; ?></p>
				                <?php if ($product['rating']) { ?>
				                <div class="rating">
				                  <?php for ($i = 1; $i <= 5; $i++) { ?>
				                  <?php if ($product['rating'] < $i) { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } else { ?>
				                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				                  <?php } ?>
				                  <?php } ?>
				                </div>
				                <?php } ?>
				                <?php if ($product['price']) { ?>
				                <p class="price">
				                  <?php if (!$product['special']) { ?>
				                  <?php echo $product['price']; ?>
				                  <?php } else { ?>
				                   <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
				                  <?php } ?>
				                  <?php if ($product['tax']) { ?>
				                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
				                  <?php } ?>
				                </p>
				                <?php } ?>
				              </div>
				              <div class="button-group">
				                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
				                <div class="cart enquiry-button">
				                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
				                </div>
				                <?php else: ?>
					                <?php if($product['special']):?>
					                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?> intel_button">
					                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top intel_button" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
					                </div>
					                <?php endif;?>
				                <?php endif; ?>
				                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
				                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
				              </div>
				            </div>
				          </div>
				        </div>
		        	<?php endforeach; ?>
      			
      			<?php } ?>
      		</div>
	
      <?php endif;?>
	  <!-- This is End of precious Memory Page ID -->
      
      <?php if ($products) { ?>

      <div class="product-filter">
        <div class="display">
          <a onclick="Journal.gridView()" class="grid-view"><?php echo $this->journal2->settings->get("category_grid_view_icon", $button_grid); ?></a>
          <a onclick="Journal.listView()" class="list-view"><?php echo $this->journal2->settings->get("category_list_view_icon", $button_list); ?></a>
        </div>
        <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
        <div class="limit"><b><?php echo $text_limit; ?></b>
          <select onchange="location = this.value;">
            <?php foreach ($limits as $limits) { ?>
            <?php if ($limits['value'] == $limit) { ?>
            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="sort"><b><?php echo $text_sort; ?></b>
          <select onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
      </div>

      <div class="row main-products product-list" data-grid-classes="<?php echo $this->journal2->settings->get('product_grid_classes'); ?> display-<?php echo $this->journal2->settings->get('product_grid_wishlist_icon_display'); ?> <?php echo $this->journal2->settings->get('product_grid_button_block_button'); ?>">
        <?php foreach ($products as $product) { ?>
        <div class="product-list-item xs-100 sm-100 md-100 lg-100 xl-100">
          <div class="product-thumb <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
            <div class="image">
              <a href="<?php echo $product['href']; ?>" <?php if(isset($product['thumb2']) && $product['thumb2']): ?> class="has-second-image" style="background: url('<?php echo $product['thumb2']; ?>') no-repeat;" <?php endif; ?>>
                  <img class="lazy first-image" width="<?php echo $this->journal2->settings->get('config_image_width'); ?>" height="<?php echo $this->journal2->settings->get('config_image_height'); ?>" src="<?php echo $this->journal2->settings->get('product_dummy_image'); ?>" data-src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" />
              </a>
              <?php if (isset($product['labels']) && is_array($product['labels'])): ?>
              <?php foreach ($product['labels'] as $label => $name): ?>
              <?php if ($label === 'outofstock'): ?>
              <img class="outofstock" <?php echo Journal2Utils::getRibbonSize($this->journal2->settings->get('out_of_stock_ribbon_size')); ?> style="position: absolute; top: 0; left: 0" src="<?php echo Journal2Utils::generateRibbon($name, $this->journal2->settings->get('out_of_stock_ribbon_size'), $this->journal2->settings->get('out_of_stock_font_color'), $this->journal2->settings->get('out_of_stock_bg')); ?>" alt="" />
              <?php else: ?>
              <span class="label-<?php echo $label; ?>"><b><?php echo $name; ?></b></span>
              <?php endif; ?>
              <?php endforeach; ?>
              <?php endif; ?>
              <?php if($this->journal2->settings->get('product_grid_wishlist_icon_position') === 'image' && $this->journal2->settings->get('product_grid_wishlist_icon_display', '') === 'icon'): ?>
                  <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                  <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
              <?php endif; ?>
            </div>
            <div class="product-details">
              <div class="caption">
                <h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
                <p class="description"><?php echo $product['description']; ?></p>
                <?php if ($product['rating']) { ?>
                <div class="rating">
                  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($product['rating'] < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                  <?php } ?>
                  <?php } ?>
                </div>
                <?php } ?>
                <?php if ($product['price']) { ?>
                <p class="price">
                  <?php if (!$product['special']) { ?>
                  <?php echo $product['price']; ?>
                  <?php } else { ?>
                  <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new" <?php echo isset($product['date_end']) && $product['date_end'] ? "data-end-date='{$product['date_end']}'" : ""; ?>><?php echo $product['special']; ?></span>
                  <?php } ?>
                  <?php if ($product['tax']) { ?>
                  <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                  <?php } ?>
                </p>
                <?php } ?>
              </div>
              <div class="button-group">
                <?php if (Journal2Utils::isEnquiryProduct($this, $product['product_id'])): ?>
                <div class="cart enquiry-button">
                  <a href="javascript:Journal.openPopup('<?php echo $this->journal2->settings->get('enquiry_popup_code'); ?>', '<?php echo $product['product_id']; ?>');" data-clk="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $this->journal2->settings->get('enquiry_button_text'); ?>"><?php echo $this->journal2->settings->get('enquiry_button_icon') . '<span class="button-cart-text">' . $this->journal2->settings->get('enquiry_button_text') . '</span>'; ?></a>
                </div>
                <?php else: ?>
                <div class="cart <?php echo isset($product['labels']) && is_array($product['labels']) && isset($product['labels']['outofstock']) ? 'outofstock' : ''; ?>">
                  <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button hint--top" data-hint="<?php echo $button_cart; ?>"><i class="button-left-icon"></i><span class="button-cart-text"><?php echo $button_cart; ?></span><i class="button-right-icon"></i></a>
                </div>
                <?php endif; ?>
                <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_wishlist; ?>"><i class="wishlist-icon"></i><span class="button-wishlist-text"><?php echo $button_wishlist;?></span></a></div>
                <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');" class="hint--top" data-hint="<?php echo $button_compare; ?>"><i class="compare-icon"></i><span class="button-compare-text"><?php echo $button_compare;?></span></a></div>
              </div>
            </div>
          </div>
        </div>
        <?php } ?>
      </div>
      <div class="row pagination">
        <div class="col-sm-6 text-left links"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right results"><?php echo $results; ?></div>
      </div>
      <?php } ?>      
      <?php if (!$categories && !$products) { ?>
      
       	  <?php if(empty($event_description)): ?>          	  
	      <p><?php echo $text_empty; ?></p>
	      <div class="buttons">
	        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary button"><?php echo $button_continue; ?></a></div>
	      </div>
      	  <?php endif;?>
      	  
      <?php } ?>
      <?php echo $content_bottom; ?></div>
    </div>
    <script>Journal.applyView('<?php echo $this->journal2->settings->get("product_view", "grid"); ?>');</script>
    <?php if ($this->journal2->settings->get('show_countdown', 'never') !== 'never'): ?>
    <script>Journal.enableCountdown();</script>
    <?php endif; ?>
</div>
<?php echo $footer; ?>
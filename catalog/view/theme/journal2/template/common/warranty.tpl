<?php echo $header; ?>
<div id="container" class="container j-container">
  <div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?><?php echo $content_bottom; ?>
			<form action="index.php?route=common/warranty/" method="post" class="form-horizontal">
    		<div class="row">
				  <div class="col-sm-6">
				    <fieldset id="account">
				      <h2 class="secondary-title">Warranty Form</h2>
				    </fieldset>
				    
				     <img id="banner_warranty" style="width:100%;" src="http://www.tmt.my/onlinestore/image/Banner/Banner Waranty 2.jpg">
				    
				     <div class="pictureTrigger">
				      	<a href="http://www.tmt.my/onlinestore/image/Banner/Invoice_Example.PNG" class="col-sm-2 control-label " target="_blank"><b>Example Invoice No</b></a>
				      	<img id="wallpaperamIMage" style="display:none;" src="http://www.tmt.my/onlinestore/image/Banner/example_modal.PNG">										      					      	
				     </div>
				    
				     <div class="form-group required">
				      	<label class="col-sm-2 control-label"><?php echo $entry_invoice_no; ?></label>
				      	<div class="col-sm-2">
				        <input type="text" name="invoice_no" value="<?php echo $invoice_no; ?>" placeholder="<?php echo $entry_invoice_no; ?>" id="input-warranty-invoiceno" class="form-control tmt-input" />
				         <?php if ($error_invoice_no) { ?>
			              	<div class="text-danger"><?php echo $error_invoice_no; ?></div>
			             <?php } ?>
			             </div>			            
				     </div>
				     				    
				     
				     <div class="form-group required">
				        <label class="col-sm-2 control-label" for="input-warranty-name"><?php echo $entry_name; ?></label>
				        <div class="col-sm-10">
				        <input type="text" name="customer_name" value="<?php echo $firstname.' '.$lastname; ?>" placeholder="<?php echo $entry_name; ?>" id="input-warranty-name" class="form-control tmt-input" />
				         <?php if ($error_customer_name) { ?>
			              	<div class="text-danger"><?php echo $error_customer_name; ?></div>
			             <?php } ?>
			             </div>
				     </div>
				    
				     <!--div class="form-group required">
				        <label class="col-sm-2 control-label" for="input-warranty-ic"><?php echo $entry_ic; ?></label>
				        <div class="col-sm-10">
				        <input type="text" name="ic_no" value="<?php echo $ic_no; ?>" placeholder="<?php echo $entry_ic; ?>" id="input-warranty-ic" class="form-control tmt-input" />
				        <?php if ($error_ic_no) { ?>
			              	<div class="text-danger"><?php echo $error_ic_no; ?></div>
			             <?php } ?>
			             </div>
				     </div-->
				    
				     <div class="form-group required">
				        <label class="col-sm-2 control-label" for="input-warranty-telephone"><?php echo $entry_telephone; ?></label>
				        <div class="col-sm-10">
				        <input type="text" name="telephone" value="<?php echo $telephone; ?>" placeholder="<?php echo $entry_telephone; ?>" id="input-warranty-telephone" class="form-control tmt-input" />
				        <?php if ($error_telephone) { ?>
			              	<div class="text-danger"><?php echo $error_telephone; ?></div>
			             <?php } ?>
			             </div>
				     </div>
				     
				     <div class="form-group required">
				        <label class="col-sm-2 control-label" for="input-warranty-email"><?php echo $entry_email; ?></label>
				        <div class="col-sm-10">
				        <input type="text" name="email" value="<?php echo $email; ?>" placeholder="<?php echo $entry_email; ?>" id="input-warranty-email" class="form-control tmt-input" />
				        <?php if ($error_email) { ?>
			              	<div class="text-danger"><?php echo $error_email; ?></div>
			            <?php } ?>
			            </div>
				     </div>
				     
				     <div class="form-group required">
				        <label class="col-sm-2 control-label" for="input-warranty-address"><?php echo $entry_address; ?></label>
				        <div class="col-sm-10">
				        <textarea name="address" rows="5" placeholder="<?php echo $entry_address; ?>" id="input-warranty-address" class="form-control tmt-input"><?php echo $address?></textarea>				        
				        <?php if ($error_address) { ?>
			              	<div class="text-danger"><?php echo $error_address; ?></div>
			            <?php } ?>
			            </div>
				     </div>
				     				     				     
				  </div>
				  
				  <div class="buttons">
					    <input type="submit" value="<?php echo $button_submit ?>" id="button-register" class="btn btn-primary button" />
					    <input type="hidden" name="formSubmit" value="-"/>					  
				  </div>
			</div> 
			</form>     
    </div>
    
    
    
    </div>
</div>


<?php echo $footer; ?>
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
		    <div class="row">
			      <div class="col-sm-12">
				      	<fieldset id="account">
					      <h2 class="secondary-title">Warranty Form</h2>
					    </fieldset>
			    		 <p>Congratulation, you have submit warranty successfully.</p>
			    		 </br></br></br></br></br>
			      </div>	 
			</div>	    		
	    </div>
   </div>
</div>
<?php echo $footer; ?>
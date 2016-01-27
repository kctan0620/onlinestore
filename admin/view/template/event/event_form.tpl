<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-marketing" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
                              
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-event" class="form-horizontal">
        
        	<div class="form-group required">        		
		        <label class="col-sm-2 control-label label_c" for="category_id">Category Id:</label> 
	        	<div class="col-sm-10">
	            	<input class="form-control input_c" type="text" name="category_id" id="category_id" value="<?php echo $category_id; ?>" placeholder="" >
	            </div>
        	</div>   
        	
        	<div class="form-group required">        		
		        <label class="col-sm-2 control-label label_mb" for="main_banner">Category Top Banner:</label> 
	        	<div class="col-sm-10">
	            	<!--input class="form-control input_mb" type="text" name="main_banner" id="main_banner" value="<?php echo $main_banner; ?>" placeholder="" -->
	            	<textarea name="main_banner" placeholder="Image Banner" id="main_banner" class="form-control input_mb"><?php echo $main_banner?></textarea>
	            </div>
        	</div>   
        	
        	<!--  Just a template for clone -->
        	<div id="entry0" class="clonedInput" style="display:none">
                <h2 id="reference" name="reference" class="heading-reference">Event Section #0</h2>
                
                <div class="form-group required">
                    <label class="col-sm-2 control-label label_n" for="name">Name Highlight:</label>
 					<div class="col-sm-10">
                    	<input class="form-control form-control input_n" type="text" name="name" id="name" value="">
 					</div>                        
                </div>
                
                <div class="form-group">
                    <label class="col-sm-2 control-label label_eu" for="name">Event URL:</label>
 					<div class="col-sm-10">
                    	<input class="form-control form-control input_eu" type="text" name="event_url" id="event_url" value="">
 					</div>                        
                </div>
 
                <div class="form-group">
                    <label class="col-sm-2 control-label label_d" for="description">Description:</label>
                    <div class="col-sm-10">
                    <!--input class="form-control input_d" type="text" name="description" id="description" value=""-->
                    
                    <textarea name="description" placeholder="Image Banner" id="description_0" class="form-control input_d"></textarea>
                    
                    </div>
                </div>
                
                <div class="form-group">
                    <label class=" col-sm-2 control-label label_sb" for="sort_by">Sort By:</label>
                    <div class="col-sm-10">
                    <input class="form-control input_sb" type="text" name="sort_by" id="sort_by" value="">
                    </div>
               </div>
                
                <div class="form-group input_fields_wrap" id="input_fields_wrap_0">
                    <label class="col-sm-2 control-label label_p" for="product">Product:</label>
                    <div class="col-sm-2">
                    <input class="form-control input_p" type="text"  value="">
                    </div>                                      
               </div>
                <a class="add_field_button" id="more_button_0" onclick="add_new_row(0)">Add More Products</a>


            </div><!-- end #entry0 -->
            
            <?php 
            	$i = 1;
            	if(isset($events)):
            	foreach($events as $event_value):            		
            ?>            
            	<div id="entry<?php echo $i?>" class="clonedInput">
	                <h2 id="reference" name="reference" class="heading-reference">Event Section <?php echo $i?></h2>
	                
	                <div class="form-group required">
	                    <label class="col-sm-2 control-label label_n" for="name">Name Highlight:</label>
	 					<div class="col-sm-10">
	                    <input class="form-control input_n" type="text" name="name[]" id="name" value="<?php echo $event_value['event_name'];?>">
	 					</div>	                    
	               </div>
	               
	               	<div class="form-group">
	                    <label class="col-sm-2 control-label label_eu" for="name">Event URL:</label>
	 					<div class="col-sm-10">
	                    	<input class="form-control form-control input_eu" type="text" name="event_url[]" id="event_url" value="<?php echo $event_value['event_url'];?>">
	 					</div>                        
	                </div>
	 
	                <div class="form-group">
	                    <label class="col-sm-2 control-label label_d" for="description">Description:</label>
	                    <div class="col-sm-10">
	                    <!--input class="form-control input_d" type="text" name="description[]" id="description" value="<?php echo $event_value['event_description'];?>"-->
	                    
	                    <textarea name="description[]" placeholder="Image Banner" id="description_<?php echo $i?>" class="form-control input_d"><?php echo $event_value['event_description'];?></textarea>
	                    
	                    </div>
	               </div>
	                
	                <div class="form-group">
	                    <label class="col-sm-2 control-label label_s" for="sort_by">Sort By:</label>
	                    <div class="col-sm-10">
	                    <input class="form-control input_s" type="text" name="sort_by[]" id="sort_by" value="<?php echo $event_value['sort_by'];?>">
	                    </div>
	               </div>
	                
	               
	                
	                <div class="form-group required input_fields_wrap" id="input_fields_wrap_<?php echo $i?>">
	                    <label class="col-sm-2 control-label label_p" for="product">Product:</label>
	                    
	                    <?php foreach($event_value['products'] as $key => $products): ?>
	                    	<div class="col-sm-2">
	                    	<?php if ($key == 0):?>	 	                    	
	                    	<div><input class="form-control col-sm-2 input_p" type="text" name="product[<?php echo $i?>][]" id="product[<?php echo $i?>][]" value="<?php echo $products['product_id']?>"></div>
	                    	<?php else:?>
	                    	<div><input class="form-control col-sm-2 input_p" type="text" name="product[<?php echo $i?>][]" id="product[<?php echo $i?>][]" value="<?php echo $products['product_id']?>"></div>
	                    	<?php endif;?>
	                    	</div>
	                    <?php endforeach;?>
	               </div>
	                
	                <a class="add_field_button" id="more_button_1" onclick="add_new_row('<?php echo $i?>')">Add More Products</a>
	
	             </div><!-- end #entry1 -->         
            <?php 
            	$i++;
            	endforeach; 
            	endif;
            ?>
            
            
        
            <div id="entry<?php echo $i?>" class="clonedInput">
                <h2 id="reference" name="reference" class="heading-reference">Event Section #<?php echo $i?></h2>
                
                <div class="form-group required">
                    <label class="col-sm-2 control-label label_n" for="name">Name Highlight:</label>
 					<div class="col-sm-10">
                    <input class="form-control input_n" type="text" name="name[]" id="name" value="">
 					</div>                      
               </div>
               
               <div class="form-group">
	                    <label class="col-sm-2 control-label label_eu" for="name">Event URL:</label>
	 					<div class="col-sm-10">
	                    	<input class="form-control form-control input_eu" type="text" name="event_url[]" id="event_url_<?php echo $i?>" value="">
	 					</div>                        
	           </div>
 
                <div class="form-group">
                    <label class="col-sm-2 control-label label_d" for="description">Description:</label>
                    <div class="col-sm-10">
                    <!--input class="form-control input_d" type="text" name="description[]" id="description_<?php echo $i?>" value=""-->
                    <textarea name="description[]" placeholder="Image Banner" id="description_<?php echo $i?>" class="form-control input_d"></textarea>
                    </div>
               </div>
                
                <div class="form-group">
                    <label class="col-sm-2 label_s control-label" for="sort_by">Sort By:</label>
                    <div class="col-sm-10">
                    <input class="form-control input_s" type="text" name="sort_by[]" id="sort_by" value="">
                    </div>
               </div>
                
                <div class="form-group required input_fields_wrap" id="input_fields_wrap_<?php echo $i?>">
                    <label class="col-sm-2 label_p control-label" for="product">Product:</label>
                    <div class="col-sm-2">
                    <input class="form-control input_p" type="text" name="product[<?php echo $i?>][]" id="product[<?php echo $i?>][]" value="">
                    </div>                                      
               </div>
                <a class="add_field_button" id="more_button_1" onclick="add_new_row(<?php echo $i?>)">Add More Products</a>

             </div><!-- end #entry1 -->
 
            <div id="addDelButtons">
                <input type="button" id="btnAdd" value="add section"> <input type="button" id="btnDel" value="remove section above">
            </div>
 
           
 
            <div class="form-actions">
                <input type="submit" value="Submit">
           </div>
        </form>
              
      </div>
    </div>
    
  </div>
  <script type="text/javascript"><!--
  $(function () {

	  
	  	
	    $('#btnAdd').click(function () {
	        var num     = $('.clonedInput').length - 1, // how many "duplicatable" input fields we currently have
	            newNum  = new Number(num + 1),      // the numeric ID of the new input field being added
	            newElem = $('#entry0').clone().attr('id', 'entry' + newNum).fadeIn('slow'); // create the new element via clone(), and manipulate it's ID using newNum value
	    	// manipulate the name/id values of the input inside the new element
	        // H2 - section
	        
	        
	    
	    	
	        newElem.find('.heading-reference').attr('id', 'ID' + newNum + '_reference').attr('name', 'ID' + newNum + '_reference').html('Event Section #' + newNum);
	 
	        // Name - text
	        newElem.find('.label_n').attr('for', 'ID' + newNum + '_name');
	        newElem.find('.input_n').attr('id', 'name[]').attr('name', 'name[]').val('');

	        // Event URL - text
	        newElem.find('.label_eu').attr('for', 'ID' + newNum + '_event_url');
	        newElem.find('.input_eu').attr('id', 'event_url[]').attr('name', 'event_url[]').val('');
	 
	        // Description - text
	        newElem.find('.label_d').attr('for', 'ID' + newNum + '_description');
	        newElem.find('.input_d').attr('id', 'description_' + newNum).attr('name', 'description[]');

	       
			// Debug why after clone cant get textarea value in PHP	        	        
	      
	        //active_summernote(newNum);
	        
	        
	        
			// Sort By - text
			newElem.find('.label_sb').attr('for', 'ID' + newNum + '_sort_by');
	        newElem.find('.input_sb').attr('id', 'sort_by[]').attr('name', 'sort_by[]').val('');	        			 
	 	        
	     	// Product - text
	        newElem.find('.label_p').attr('for', 'ID' + newNum + '_product');	     
	        newElem.find('.input_p').attr('id', 'ID' + newNum + '_product').attr('name', 'product['+ newNum +'][]').val('');

	        newElem.find('.add_field_button').attr('id', 'more_button_' + newNum).attr("onclick","add_new_row("+ newNum +")");	   
	        newElem.find('.input_fields_wrap').attr('id', 'input_fields_wrap_' + newNum);

	        
	    // insert the new element after the last "duplicatable" input field
	        $('#entry' + num).after(newElem);	        
	        $('#ID' + newNum + '_title').focus();
	 
	    // enable the "remove" button
	        $('#btnDel').attr('disabled', false);
	    });

	    
	    $('#btnDel').click(function () {
	    // confirmation
	        if (confirm("Are you sure you wish to remove this section? This cannot be undone."))
	            {
	                var num = $('.clonedInput').length;
	                // how many "duplicatable" input fields we currently have
	                $('#entry' + num).slideUp('slow', function () {$(this).remove(); 
	                // if only one element remains, disable the "remove" button
	                    if (num -1 === 1)
	                $('#btnDel').attr('disabled', true);
	                // enable the "add" button
	                $('#btnAdd').attr('disabled', false).prop('value', "add section");});
	            }
	        return false;
	             // remove the last element
	 
	    // enable the "add" button
	        $('#btnAdd').attr('disabled', false);
	    });
	 
	    $('#btnDel').attr('disabled', true);

	});



  function active_summernote(param){


	  $('#description_' + param).summernote({
			height: 300
	  });
	  
  }	

  function add_new_row(param){

	  console.log(param);
	  	  var wrapper         = $("#input_fields_wrap_" + param); //Fields wrapper            
          $(wrapper).append('<div  class="col-sm-2"><input class="form-control input_ln" type="text" name="product['+param+'][]" id="product['+param+'][]" value="" /><a class="remove_field"  >Remove</a></div>'); //add input box
                          
          
//       $(wrapper).on("click",".remove_field", function(e){ //user click on remove text
//           e.preventDefault(); $(this).parent('div').remove(); x--;
//       })
	}

 
	
	
<?php 
$j = 1;
	if(isset($events)):
		foreach($events as $event_value): 
?>
	$('#description_<?php echo $j?>').summernote({
		height: 300
	});
<?php
		$j++; 
		endforeach;
	endif;
?>

$('#description_<?php echo $j?>').summernote({
	height: 300
}); 

$('#main_banner').summernote({
	height: 300
});  



//--></script></div>
<?php echo $footer; ?>

<style type="text/css">
.CSSTableGenerator {
	margin:0px;padding:0px;
	width:100%;
	box-shadow: 10px 10px 5px #888888;
	border:1px solid #000000;
	
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
	
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
	
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
	
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}.CSSTableGenerator table{
    border-collapse: collapse;
        border-spacing: 0;
	width:100%;
	/*height:100%;*/
	margin:0px;padding:0px;
}.CSSTableGenerator tr:last-child td:last-child {
	-moz-border-radius-bottomright:0px;
	-webkit-border-bottom-right-radius:0px;
	border-bottom-right-radius:0px;
}
.CSSTableGenerator table tr:first-child td:first-child {
	-moz-border-radius-topleft:0px;
	-webkit-border-top-left-radius:0px;
	border-top-left-radius:0px;
}
.CSSTableGenerator table tr:first-child td:last-child {
	-moz-border-radius-topright:0px;
	-webkit-border-top-right-radius:0px;
	border-top-right-radius:0px;
}.CSSTableGenerator tr:last-child td:first-child{
	-moz-border-radius-bottomleft:0px;
	-webkit-border-bottom-left-radius:0px;
	border-bottom-left-radius:0px;
}.CSSTableGenerator tr:hover td{
	
}
.CSSTableGenerator tr:nth-child(odd){ background-color:#00ffff; }
.CSSTableGenerator tr:nth-child(even)    { background-color:#ffffff; }.CSSTableGenerator td{
	vertical-align:middle;
	
	
	border:1px solid #000000;
	border-width:0px 1px 1px 0px;
	text-align:left;
	padding:7px;
	font-size:10px;
	font-family:Arial;
	font-weight:normal;
	color:#000000;
}.CSSTableGenerator tr:last-child td{
	border-width:0px 1px 0px 0px;
}.CSSTableGenerator tr td:last-child{
	border-width:0px 0px 1px 0px;
}.CSSTableGenerator tr:last-child td:last-child{
	border-width:0px 0px 0px 0px;
}
.CSSTableGenerator tr:first-child td{
		background:-o-linear-gradient(bottom, #007fff 5%, #0000bf 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #007fff), color-stop(1, #0000bf) );
	background:-moz-linear-gradient( center top, #007fff 5%, #0000bf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#007fff", endColorstr="#0000bf");	background: -o-linear-gradient(top,#007fff,0000bf);

	background-color:#007fff;
	border:0px solid #000000;
	text-align:center;
	border-width:0px 0px 1px 1px;
	font-size:14px;
	font-family:Arial;
	font-weight:bold;
	color:#ffffff;
}
.CSSTableGenerator tr:first-child:hover td{
	background:-o-linear-gradient(bottom, #007fff 5%, #0000bf 100%);	background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #007fff), color-stop(1, #0000bf) );
	background:-moz-linear-gradient( center top, #007fff 5%, #0000bf 100% );
	filter:progid:DXImageTransform.Microsoft.gradient(startColorstr="#007fff", endColorstr="#0000bf");	background: -o-linear-gradient(top,#007fff,0000bf);

	background-color:#007fff;
}
.CSSTableGenerator tr:first-child td:first-child{
	border-width:0px 0px 1px 0px;
}
.CSSTableGenerator tr:first-child td:last-child{
	border-width:0px 0px 1px 1px;
}
</style>
<?php echo $header; ?>
<div class="container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?></div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>


  


<div class="CSSTableGenerator" >



                <table >


                    <tr>
				
                        <td>
                            <?php echo $text_orderid; ?>
                        </td>
                        <td >
                            <?php echo $text_dateoforder; ?>
                        </td>
                        <td>
                            <?php echo $text_serialkey; ?>
                        </td>
						<td>
                            <?php echo $text_instructions; ?>
                        </td>
                    </tr>
                    <?php foreach ($serialkeys as $serialkey) { ?>    

    <tr>
	
		<td><?php echo $serialkey['order_id']; ?></td>
		<td><?php echo $serialkey['date_added']; ?></td>
		<td>
			<?php echo $text_productname; ?>&nbsp;<?php echo $serialkey['productname']; ?>
			<br />
			<?php echo $serialkey['serialkey']; ?>
			<br />
			<br />
			<a href="<?php echo $serialkey['downloadlink']; ?>" target="_blank"><?php echo $serialkey['downloadlink']; ?></a>
		</td>
		<td><a href="<?php echo $serialkey['instructions_link']; ?>" ><?php echo $serialkey['instructions_title']; ?></a></td>
    </tr>

      <?php } ?>
                  
                </table>
            </div>

<!-- END OF TABLE -->


	

  
    

  <div class="pagination"><?php echo $pagination; ?></div>

  <div class="buttons clearfix">

    <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>

  </div>

  <?php echo $content_bottom; ?></div>
    <?php echo $column_right; ?></div>
</div>
<?php echo $footer; ?>
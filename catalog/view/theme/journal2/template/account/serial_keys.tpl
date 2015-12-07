<?php echo $header; ?>
<div id="container" class="container j-container">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
 
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>

	<div class="row"><?php echo $column_left; ?><?php echo $column_right; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
  	<div id="content" class="<?php echo $class; ?> serial-list">
      <h1 class="heading-title"><?php echo $heading_title; ?></h1>
      <?php echo $content_top; ?>     
      <?php if ($serialkeys) { ?>
      <div class="table-responsive">
        <table class="table table-bordered table-hover list">
          <thead>
            <tr>
              <td class="text-right"><?php echo $text_orderid; ?></td>
              <td class="text-left"><?php echo $text_dateoforder; ?></td>
              <td class="text-left"><?php echo $text_serialkey; ?></td>
              <td class="text-right"><?php echo $text_instructions; ?></td>            
            </tr>
          </thead>
          <tbody>
            <?php foreach ($serialkeys as $serialkey) { ?>
            <tr>
              <td class="text-right"><?php echo $serialkey['order_id']; ?></td>
              <td class="text-left"><?php echo $serialkey['date_added']; ?></td>
              <td class="text-left">
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
          </tbody>
        </table>
      </div>
      
      <div class="text-right"><?php echo $pagination; ?></div>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary button"><?php echo $button_continue; ?></a></div>
      </div>
      <?php echo $content_bottom; ?></div>
    </div>
</div>

<?php echo $footer; ?>
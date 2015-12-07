<?php echo $header; ?>
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
    <div id="content" class="<?php echo $class; ?> order-list">
      <h1 class="heading-title"><?php echo $heading_title; ?></h1>
      <?php echo $content_top; ?>
      <?php if ($warranties) { ?>
      <div class="table-responsive">
        <table class="table table-bordered table-hover list">
          <thead>
            <tr>
              <td class="text-right"><?php echo $column_invoice_no; ?></td>
              <td class="text-left"><?php echo $column_name; ?></td>
              <td class="text-left"><?php echo $column_email; ?></td>
              <td class="text-right"><?php echo $column_telephone; ?></td>
              <td class="text-left"><?php echo $column_created_dt; ?></td>              
              <!--td></td-->
            </tr>
          </thead>
          <tbody>
            <?php foreach ($warranties as $warranty) { ?>
            <tr>
              <td class="text-right">#<?php echo $warranty['invoice_no']; ?></td>
              <td class="text-left"><?php echo $warranty['customer_name']; ?></td>
              <td class="text-left"><?php echo $warranty['email']; ?></td>
              <td class="text-right"><?php echo $warranty['telephone']; ?></td>
              <td class="text-left"><?php echo $warranty['created_dt']; ?></td>              
              <!--td class="text-right"><a href="<?php echo $warranty['href']; ?>" data-toggle="tooltip" title="<?php echo $button_view; ?>" class="btn btn-info btn-primary"><i class="fa fa-eye"></i></a></td-->
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
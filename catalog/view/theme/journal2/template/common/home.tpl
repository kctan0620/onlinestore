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
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?><?php echo $content_bottom; ?></div>
    </div>
</div>

<!-- This is a banner show at bottom website -->
<!--div id="footerSlideContainer">
	<div id="footerSlideButton" style="background-position: 0% 100%;"></div>
	<div id="footerSlideContent" class="open">
		<div id="footerSlideText">
			<h3>Dear Customers,</h3>
			<p>We are implementing a significant upgrade to our website. </p>
			<p>If have any difficulty accessing to your member account, please get be in touched with our support team for further assistance.</p>
			<p>We would like to apologise for the inconvenience caused. </p>				
		</div>
	</div>
</div-->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery.transit/0.9.9/jquery.transit.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"></script>
<script>
var open = false;
$('#footerSlideButton').click(function () {	
	if(open === false) {		
		if(Modernizr.csstransitions) {
			$('#footerSlideContent').addClass('open');
		} else {
			$('#footerSlideContent').animate({ height: '300px' });
		}
		$(this).css('backgroundPosition', 'bottom left');
		open = true;
	} else {
		console.log("close");
				
		if(Modernizr.csstransitions) {
			$('#footerSlideContent').removeClass('open');
		} else {
			$('#footerSlideContent').animate({ height: '0px' });
		}
		$(this).css('backgroundPosition', 'top left');
		$('#footerSlideButton').hide();
		open = false;
	}
});		
</script>

<?php echo $footer; ?>
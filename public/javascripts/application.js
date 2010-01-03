(function($) {
	$('document').ready(function() {
		$('.calendar .day').click(function() {
			$('#responsibilities ul').html($(this).find('.responsibilities ul').clone());
			$('#responsibilities_date').text($(this).find('.date').text());
		});
		
		$('.calendar .day').mouseover(function() { $(this).addClass('dayHovered'); })
						   .mouseout(function() { $(this).removeClass('dayHovered'); });
	});
})(jQuery);

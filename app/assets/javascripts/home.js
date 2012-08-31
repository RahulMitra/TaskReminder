// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
			
	$(function()
	{
		$('.datepick').each(function()	
		{
		    $(this).datepicker();
			
			$(this).datepicker().on('changeDate', function(ev)
			{
				$(this).datepicker('hide');
			});
		});
	});		
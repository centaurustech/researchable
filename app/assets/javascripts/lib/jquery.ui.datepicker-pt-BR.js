jQuery(function($){
	$.datepicker.regional['en-US'] = {
		closeText: 'Close',
		prevText: 'Previous',
		nextText: 'Next',
		currentText: 'Current',
		monthNames: ["January","February","March","April","May","June","July","August","September","October","November","December"],
		monthNamesShort: ['Jan','Feb','Mar','Apr','May','Jun',
		'Jul','Aug','Sep','Oct','Nov','Dec'],
		dayNames: ['Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'],
		dayNamesShort: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
		dayNamesMin: ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'],
		weekHeader: 'Sm',
		dateFormat: 'dd/mm/yy',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['en-US']);
});
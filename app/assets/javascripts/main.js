(function ($) {
    $(document).on('click', '#login-form-link', function(ev){
			$("#login-form").delay(100).fadeIn(100);
 			$("#register-form").fadeOut(100);
			$('#register-form-link').removeClass('active');
			$(this).addClass('active');
			ev.preventDefault();
		});

		$(document).on('click', '#register-form-link', function(ev){
			$("#register-form").delay(100).fadeIn(100);
	 		$("#login-form").fadeOut(100);
			$('#login-form-link').removeClass('active');
			$(this).addClass('active');
			ev.preventDefault();
		});

})(jQuery);
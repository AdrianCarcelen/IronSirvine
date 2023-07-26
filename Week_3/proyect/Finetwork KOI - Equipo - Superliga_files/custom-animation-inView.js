// This function animates the content when is visible for the first time to the user
// Usage:
// <div animate = "fadeInUp" class="animated slow"> ... </div>



jQuery( document ).ready(function() {

    function checkVisibility() {
      jQuery('[animate]').each(function() {
        if(jQuery(this).inView("topOnly")) {
          jQuery(this).addClass(jQuery(this).attr('animate'));
        }
      });
    }

    checkVisibility();

  	jQuery(window).scroll(function() {
  	  checkVisibility();
  	});

});

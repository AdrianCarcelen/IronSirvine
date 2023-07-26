let cellSelected = jQuery('#starter-filter');

jQuery( document ).ready(function() {

    jQuery(".mvp-item").on('click', function () {
        let key = jQuery(this).attr('data-mvp');
        jQuery('.mvp-item').removeClass('mvp-active');
        jQuery(this).addClass('mvp-active');
        jQuery('.mvp-selected').addClass('d-none');
        jQuery("#mvp"+key).removeClass('d-none');

    });

    jQuery('.match-result-container-outer').click(function() {
      let url = jQuery(this).attr('match-url');
      window.location.href = url;
    })

    jQuery(".selector-option").click(function() {
      let roundSelected = jQuery(this).attr('round-selected');
      updateRoundSelector(roundSelected);
    });

    jQuery(".small-report").click(function() {
      window.location.href = jQuery(this).attr('noticia-id');
    });

    jQuery(".extra-info-expand").click(function() {
      let matchId = jQuery(this).attr('match-id');

      jQuery('#result-'+matchId).toggleClass("d-none");
      jQuery('#result-ff-'+matchId).toggleClass("d-none");
      if (jQuery('#result-'+matchId).hasClass("d-none") || jQuery('#result-ff-'+matchId).hasClass("d-none")) {
        jQuery('#show-more-text-'+matchId).text("MOSTRAR MÁS");
        jQuery('#show-more-image-'+matchId).removeClass("rotate-180-deg");
      }
      else {
        jQuery('#show-more-text-'+matchId).text("OCULTAR");
        jQuery('#show-more-image-'+matchId).addClass("rotate-180-deg");
      }

    });

    // let round = jQuery(".round").attr('data-round');
    // jQuery(".match-result").addClass('d-none');
    // jQuery(".match-result"+round).removeClass('d-none');
    //
    // jQuery('#go-to-round').click(function() {
    //   $('html, body').animate({
    //     scrollTop: $("#current-round-container").offset().top
    //   }, 1000);
    // });

    jQuery('.menu-item').click(function() {
      if(jQuery(this).find('.sub-menu-open').length > 0) {
        jQuery(this).find('.sub-menu-open').first().removeClass('sub-menu-open');
      }
      else {
        jQuery(this).find('.sub-menu').first().addClass('sub-menu-open');
      }
    });

    jQuery('.table-row-mvps').click(function() {
      let url = jQuery(this).attr('player-url');
      window.location.href = url;
    });

    function checkVisibility() {
      jQuery('[animate]').each(function() {
        if(jQuery(this).inView("topOnly")) {
          jQuery(this).addClass(jQuery(this).attr('animate'));
        }
      });
    }

});

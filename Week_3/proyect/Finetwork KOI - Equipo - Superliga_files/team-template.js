window.multiTemplateCache = {} // prepare a cache object

jQuery().ready( function($) {
  // let roundid = parseInt($('#selectedRound').attr('data-template'));
  let competitionid = $('#round-phase-selected').attr('selected-competition');
  let competitionOrder = $('#round-phase-'+competitionid).attr('competition-order');
  window.multiTemplateCache['template_' + competitionid] = $('#dynamic-result-template').html();
  changeRoundArrow(competitionid);
  // arrowController(competitionid);

  $('#round-phase-left').click( function() {
    let competitionid = $('#round-phase-selected').attr('selected-competition');
    let competitionOrder = $('#round-phase-'+competitionid).attr('competition-order');
    //
    let nextOrder = parseInt(competitionOrder) - 1;
    let nextCompetitionId = ($('#round-phase-'+nextOrder).attr('competition-id'));
    changeRoundArrow(nextCompetitionId);

  });

  $('#round-phase-right').click( function() {
    let competitionid = $('#round-phase-selected').attr('selected-competition');
    let competitionOrder = $('#round-phase-'+competitionid).attr('competition-order');
    //
    let nextOrder = parseInt(competitionOrder) + 1;
    let nextCompetitionId = ($('#round-phase-'+nextOrder).attr('competition-id'));
    changeRoundArrow(nextCompetitionId);

  });

  $('#round-phase-selected').click( function() {
    closeRoundExpand();
  });

  $(document).click(function(event) {
    let objectid = event.target.id;
    if (!objectid.startsWith('round-phase-selected') && objectid != 'round-txt') $('#round-expand').css('max-height', '0px');
  });

  $('.competition-phase').click( function() {
    let phaseId = $(this).attr('competition-order');

    let nextCompetition = $('#round-phase-'+phaseId).attr('competition-id');
    changeRoundArrow(nextCompetition);
  });

});

function changeRoundArrow(competitionid) {

  let teamSlug = $('#round-phase-selected').attr('team-slug');
  let phaseLabel = $('#round-phase-'+competitionid).attr('competition-phase-label');
  $('#round-phase-selected').text(phaseLabel);

  if ( window.multiTemplateCache['template_' + competitionid] ) {
    $('#dynamic-result-template').html( window.multiTemplateCache['template_' + competitionid] );
    arrowController(competitionid);
    $("#round-phase-selected").attr('selected-competition', competitionid);
    checkVisibility();
  }
  else { // not in cache, retrieve via ajax
    $('#dynamic-result-template').html( '<div class="d-flex justify-content-center spinner-lvp"><div class="spinner-border" role="status"><span class="sr-only">Loading...</span></div></div>' );
    $.get(
      multiTemplateData.url,
      {
        postId: multiTemplateData.id,
        action: 'multi_team_template_callback',
        selectedCompetition: competitionid,
        teamSlug: teamSlug
      },
      function( data ) {
        // cache the template
        window.multiTemplateCache['template_' + competitionid] = data;
        $('#dynamic-result-template').html( data );
        $("#round-phase-selected").attr('selected-competition', competitionid);
        arrowController(competitionid);
        checkVisibility();
      }
    );
  }
}

function checkVisibility() {
  jQuery('[animate]').each(function() {
    if(jQuery(this).inView("topOnly")) {
      jQuery(this).addClass(jQuery(this).attr('animate'));
    }
  });
}

function arrowController(competitionid) {

  let totalCompetitions = $('#round-expand').attr('max-competitions-phases');
  let competitionOrder = $('#round-phase-'+competitionid).attr('competition-order');
  //
  if (competitionOrder == 1) $('#round-phase-left').addClass('disabled');
  else $('#round-phase-left').removeClass('disabled');
  //
  if (competitionOrder == totalCompetitions) $('#round-phase-right').addClass('disabled');
  else $('#round-phase-right').removeClass('disabled');
}

function closeRoundExpand() {
  let currentHeight = $('#round-expand').css('max-height');
  if (currentHeight == '0px') $('#round-expand').css('max-height', '2000px');
  else $('#round-expand').css('max-height', '0px');
}

$(document).ready(function() {
	$( ".slider" ).slider({
    value: 50,
    min: 10,
    max: 100,
    step: 10,
    slide: function(e, ui) {
      $("#slider-result").html(ui.value);
    }
  });

  $('#new_filteritem').click(function() {
    alert("Yeaaah you clicked me!!");
  });
});

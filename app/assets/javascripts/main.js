/*$(document).ready(function() {
	$( ".slider" ).slider({
    value: 50,
    min: 10,
    max: 100,
    step: 10,
    slide: function(e, ui) {
      $("#slider-result").html(ui.value);
    }
  });
});*/


(function($) {
  window.Filter = Backbone.Model.extend({
  });

  window.Filters = Backbone.Collection.extend({
    model: Filter
  });

  window.FilterView = Backbone.View.extend({
    initialize: function() {

    },
    render: function() {
      var template = _.template( $("#slider_template").html(), {});
      this.el.html(template);
    }
  });

  $(document).ready(function() {
    var filter_view = new FilterView({el: $('#sliders')});
    
    $("#new_subreddit").click(function() {
      // User wants to add a new subreddit
    });
  });
})(jQuery);


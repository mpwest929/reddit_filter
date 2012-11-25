$(document).ready(function() {
  var refresh_articles = function() {
    $.get("/collection.json", function(data) {
      alert(data);
    });
  }

  var add_filter = function(subreddit) {
    $.post("/filters.json", "{'subreddit':'"+subreddit+"'}", function(data) {

    });
  }

  $("#add_subreddit").click(function() {
    var new_subreddit = $("#subreddit").val();

    if (new_subreddit === "") {
      alert("Please provide a subreddit");
    }
    else {
      add_filter(new_subreddit);
      var slider_html = $("<div class='slider'><div>");
      slider_html.slider({
        value: 50,
        min: 10,
        max: 100,
        step: 10,
        slide: function(e, ui) {
          $("#slider-result").html(ui.value);
        }
      });

      // Slider label
      $("<span>"+new_subreddit+"</span>").appendTo("#sliders");
      slider_html.appendTo("#sliders");
    }
  });
});

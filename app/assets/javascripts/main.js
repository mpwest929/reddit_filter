$(document).ready(function() {
  var subreddit_collection = {};

  var refresh_articles = function() {
    $.get(articles_uri(), function(results) {
      $("#article_container").empty();

      for (var index in results) {
        var article = results[index];

        $("<div class='article_div'><p>"+article.title+"</p><a href='"+article.url+"'>"+article.url+"</a></div>").appendTo("#article_container");
      }
    });
  }

  var articles_uri = function() {
    var query_param = ""
    for (var subreddit_name in subreddit_collection) {
      query_param += subreddit_name+"_"+subreddit_collection[subreddit_name];
      query_param += ",";
    }

    return "/collection.json?subreddits="+query_param;
  }

  var add_filter = function(subreddit) {
    subreddit_collection[subreddit] = 50;
    refresh_articles();
  }

  $("#add_subreddit").click(function() {
    var new_subreddit = $("#subreddit").val();

    if (new_subreddit === "") {
      alert("Please provide a subreddit");
    }
    else {
      var slider_html = $("<div class='slider' id='"+new_subreddit+"_slider'><div>");
      slider_html.slider({
        value: 50,
        min: 10,
        max: 100,
        step: 5,
        slide: function(e, ui) {
          var slider_id      = $(this).attr('id');
          var subreddit_name = slider_id.split("_")[0]; 
          subreddit_collection[subreddit_name] = ui.value;

          refresh_articles();
          $("#slider-result").html(ui.value);
        }
      });

      // Slider label
      $("<span>"+new_subreddit+"</span>").appendTo("#sliders");
      slider_html.appendTo("#sliders");

      add_filter(new_subreddit);
    }

    $("#subreddit").val('');
  });
});

require 'faraday'

module RedditClient
  def get(subreddit)
    conn = Faraday.new(:url => 'http://www.reddit.com') do |builder|
      builder.response :logger
      builder.adapter :net_http
    end

    response = conn.get "/r/#{subreddit}.json"
    JSON.parse(response.body)
  end

  def get_simple(subreddit)
    data=RedditClient.get(subreddit)
   
    simple_data=[]
    data["data"]["children"].each do |d|
      d_data = d["data"]
      simple_data << {"title" => d_data["title"], 
                      "url" => d_data["url"],
                      "score" => d_data["score"], 
                      "subreddit" => d_data["subreddit"],
                      "hot_score" => RedditClient.hot_score(d_data["score"], d_data["created_utc"])
                     }
    end
    simple_data
  end

  # This is how Reddit computes story ranking scores
  def hot_score(score, submission_date)
    order = Math.log([score,1].max) / Math.log(10)

    if score>0
      sign=1
    elsif score<0 
      sign=-1
    else
      sign=0
    end

    seconds = submission_date - 1134028003
    (order+sign*seconds/45000).round
  end
 
  def weighted_score(story, weight)
    story["hot_score"] * weight
  end

  # subreddits = {"name"=>"weight", ...}
  def merge_reddits(subreddits)
    return [] if subreddits.nil? or subreddits.empty?

    # subreddits is an array of subreddit names
    merged_data = []
    subreddits.each do |name, weight|
      subreddit_data = RedditClient.get_simple(name)
      if merged_data.empty?
        merged_data = subreddit_data.clone
        next
      end

      m_index = 0
      sr_index = 0
      new_merged_data = []
      (0..24).each do |i|
         # TODO: Fix so that weighted scores aren't re-computed over and over again
         sr_weighted_score = RedditClient.weighted_score(subreddit_data[sr_index], weight)
         m_weighted_score = RedditClient.weighted_score(merged_data[m_index], subreddits[merged_data[m_index]["subreddit"]])
         if sr_weighted_score > m_weighted_score
           new_merged_data << subreddit_data[sr_index]
           sr_index += 1
         elsif sr_weighted_score < m_weighted_score
           new_merged_data << merged_data[m_index]
           m_index += 1
         else
           # Scores are equal
           new_merged_data << merged_data[m_index]
           m_index += 1
         end
       end
       merged_data = new_merged_data.clone
    end
    merged_data
  end
end

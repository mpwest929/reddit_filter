# Load the rails application
require File.expand_path('../application', __FILE__)
require 'reddit_client'

include RedditClient

# Initialize the rails application
RedditFilter::Application.initialize!

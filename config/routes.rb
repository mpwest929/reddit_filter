RedditFilter::Application.routes.draw do
  get "home/index"

  match 'view' => 'home#index'

  match 'filters' => 'reddit_client#create_filter', :via => :post
  match 'filters/:id' => 'reddit_client#update_filter', :via => :put
  match 'filters/:id' => 'reddit_client#get_filter', :via => :get
end

RedditFilter::Application.routes.draw do
  get "home/index"

  match 'view' => 'home#index'

  match 'filters' => 'filter#create', :via => :post
  match 'filters/:id' => 'filter#update', :via => :put
  match 'filters/:id' => 'filter#get', :via => :get
  match 'collection' => 'collection#retrieve', :via => :get
end

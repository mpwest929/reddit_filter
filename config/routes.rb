RedditFilter::Application.routes.draw do
  get "home/index"

  match 'view' => 'home#index'
end

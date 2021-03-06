Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks'}
  get 'register/info1'

  get 'register/info2'

  get 'visitor/main'
  post '/search' => 'visitor#search'
  get '/search' => 'visitor#search'
  root 'visitor#main'
  
  resources :clip, except: [:new, :edit, :update, :delete, :show]
  post 'scrap/:id' => 'clip#scrap_toggle'
  post 'like/:id' => 'clip#like_toggle'

end

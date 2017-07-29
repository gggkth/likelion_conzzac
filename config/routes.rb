Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks'}
  get 'register/info1'

  get 'register/info2'

  get 'visitor/main'
  get 'visitor/main2'
  post '/search' => 'visitor#search'
  get '/search' => 'visitor#search'
  root 'visitor#main'

end

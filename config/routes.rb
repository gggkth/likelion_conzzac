Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks'}
  get 'register/info1'

  get 'register/info2'

  get 'visitor/main'
  get 'visitor/main2'

  post '/search' => 'visitor#search'
  get 'mypage/category/:name' => 'visitor#mypage'
  get 'mypage' => 'visitor#mypage'
  get 'mypage/search' => 'visitor#mypage_search'
  root 'visitor#main'
  get 'visitor/carouseltest'
  
  resources :clip, except: [:new, :edit, :update, :delete, :show]
  post 'scrap/:id' => 'clip#scrap_toggle'
  post 'like/:id' => 'clip#like_toggle'

end

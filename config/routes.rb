Rails.application.routes.draw do
  get 'likes/new'

  get '/' => 'homes#top'
  
  post 'posts/create' => 'posts#create'
  post 'posts/:id/destroy' => 'posts#destroy'
  post 'posts/:id/update' => 'posts#update'
  get 'posts/:id/edit' => 'posts#edit'
  get 'posts/new' => 'posts#new'
  get 'posts/index' => 'posts#index'
  get 'posts/:id' => 'posts#show'

  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post  'signup' => 'users#create'
  get 'signup' => 'users#new'

  get 'users/index' => 'users#index'
  get 'users/:id' => 'users#show'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'



end

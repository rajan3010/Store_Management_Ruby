Rails.application.routes.draw do
  get 'purchases/index'
  put 'purchases/show'
  get 'purchaselist/index'
  get 'purchaselist/show'
  get 'users/index'
  put 'users/:id/remove' => 'users#remove'
  get 'users/show'
  get 'feedbacks/new'
  get 'feedbacks/show'
  get 'wishlist/index'
  get 'mainpage/index'
  get 'cart/add_purchase'
  put 'items/index'
  resources :items do
    member do
      put "addcart", to: "items#cart"
      put "removecart", to: "items#cart"
      put "addwish", to: "items#wishlist"
      put "removewish", to: "items#wishlist"
    end
  end
  resources :cart, only:[:index] do
    member do
      put "clearcart", to: "cart#clear_cart"
      put "buynow", to: "cart#buy_now"
    end
  end
  resources :wishlist, only:[:index]
  resources :mainpage, only:[:index]
  resources :feedbacks
  resources :users, except: :create
  resources :purchaselist, only:[:index,:show] do
    member do
      put "returnpurchase", to: "purchaselist#return_update"
      put "approverequest", to: "purchaselist#approve_request"
    end
  end
  resources :purchases
  post 'create_user' => 'users#create' ,as: :create_user


  devise_for :users, :path_prefix => 'my', controllers:{
      registrations: 'registrations',
      confirmations: 'confirmations' ,
      omniauth_callbacks: 'omniauth'
  }

  root to: 'mainpage#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

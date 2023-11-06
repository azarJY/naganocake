Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit]
    get 'orders/show'
    resources :customers, only: [:index, :show, :edit, :update]
    get 'homes/top'
  end
  
  namespace :public do
    root to: "homes#top"
    get 'homes/about', as: 'about'
    resources :items, only: [:top, :index]
    
    resources :current_customers, only: [:show, :edit, :update]
    patch 'current_customers/unsubscribed'
    get 'current_customers/confirm'
    
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/destroy_all'
    
    resources :orders, only: [:index, :show, :new, :create]
    post 'orders/confirm'
    get 'orders/completed'
    
    resources :addreses, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

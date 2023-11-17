Rails.application.routes.draw do
  
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  root to: "public/homes#top"

  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    get 'orders/show'
    resources :customers, only: [:index, :show, :edit, :update]
    get 'homes/top'
  end
  
  namespace :public do
    root to: "homes#top"
    get 'homes/about', as: 'about'
    resources :items, only: [:top, :index, :show]
    
    resource :current_customer, only: [:show, :edit, :update] do
      member do
        get 'confirm', to: 'current_customers#confirm'
        patch 'unsubscribed', to: 'current_customers#unsubscribed'
      end
    end
    
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items/destroy_all'
    
    resources :orders, only: [:index, :show, :new, :create]
    post 'orders/confirm'
    get 'orders/completed'
    
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Daysheet::Application.routes.draw do
  
  root :to => "home#index"
  match "admin" => "admin/users#index"
  match "profile" => "users#show"

  devise_for :users do    
    get "signup", :to => "devise/registrations#new"
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
    get "invite", :to => "devise/invitations#new"
  end

  resources :users  
  resources :timesheets do
    collection do
      get :options
      post :redraw
    end
  end
  resources :calendars
  
  namespace :admin do
    resources :users do
      member do
        put :suspend
        put :reactivate
      end
      collection do
        get :search
      end
    end
  end

end

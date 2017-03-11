Rails.application.routes.draw do
  namespace :api do
    get 'companies', to: 'companies#index'
    get 'quotes', to: 'quotes#index'
  end
end

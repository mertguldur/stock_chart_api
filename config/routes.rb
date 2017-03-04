Rails.application.routes.draw do
  get 'companies', to: 'companies#index'
  get 'quotes', to: 'quotes#index'
end

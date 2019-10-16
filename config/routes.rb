Rails.application.routes.draw do
  get 'welcome/index'
  
  resources :reclamacao

  root 'welcome#index'
end

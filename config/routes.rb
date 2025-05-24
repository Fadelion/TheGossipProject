Rails.application.routes.draw do
  # Route racine vers la page d'accueil des potins
  root 'gossips#index'
  
  # Routes pour les pages statiques
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  
  # Route pour la page de bienvenue personnalisée
  get '/welcome/:first_name', to: 'welcome#show'
  
  # Routes pour les potins
  resources :gossips
  
  # Routes pour les utilisateurs
  resources :users, only: [:show]
end
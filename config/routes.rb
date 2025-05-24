Rails.application.routes.draw do
  # Route racine vers la page d'accueil des potins
  root 'gossips#index'
  
  # Routes pour les pages statiques
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  
  # Route pour la page de bienvenue personnalisée
  get '/welcome/:first_name', to: 'welcome#show'
  
  # Routes pour l'authentification
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # Routes pour les potins et leurs commentaires
  resources :gossips do
    resources :comments
    # Route pour liker un potin
    post 'like', to: 'likes#create'
  end
  
  # Route pour liker un commentaire
  resources :comments do
    post 'like', to: 'likes#create'
  end
  
  # Routes pour les utilisateurs
  resources :users, only: [:show, :new, :create]
  
  # Routes pour les villes
  resources :cities, only: [:show]
end
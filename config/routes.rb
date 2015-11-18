Rails.application.routes.draw do
  root to: redirect('/cats')

  resources :cats do
    # Don't need to nest cat_rental_requests#index;
    # Don't need a separate page
    # resources :cat_rental_requests, only: :index
  end

  resources :cat_rental_requests, path: :requests, as: :requests, only: [:new, :create] do
    post '/approve', to: 'cat_rental_requests#approve'
    post '/deny', to: 'cat_rental_requests#deny'
  end
end

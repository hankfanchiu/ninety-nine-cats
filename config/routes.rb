Rails.application.routes.draw do
  root to: redirect('/cats')

  resource :session, only: [:new, :create, :destroy]
  resources :cats, except: :destroy

  resources :cat_rental_requests, path: :requests, as: :requests, only: [:new, :create] do
    post 'approve', on: :member
    post 'deny', on: :member
  end
end

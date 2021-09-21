Rails.application.routes.draw do
  get '*all', to: 'errors#not_found', constraints: ->(req) {req.path.exclude? 'rails/active_storage'} unless Rails.env.development?
  mount Sidekiq::Web => '/sidekiq' # monitoring console
  root "home#index"
  get '/manifest.json' => 'service_worker#manifest'
  get '/service-worker.js' => 'service_worker#service_worker'
  match '/500', to: 'errors#internal_server_error', via: :all
  match '/404', to: 'errors#not_found', via: :all
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

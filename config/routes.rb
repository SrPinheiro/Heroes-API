Rails.application.routes.draw do
  resources :heroes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'ping' => ->(_) { [200, {}, ['pong']] }
end

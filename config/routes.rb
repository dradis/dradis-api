Dradis::API::Engine::routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: Dradis::API::RoutingConstraints.new(version: 1, default: true) do
      resources :issues
      resources :nodes do
        resources :evidence
        resources :notes
      end
    end
  end
end

Dradis::Application.routes.draw do
  mount Dradis::API::Engine, at: ''
end

namespace :api, defaults: {format: 'json'} do
  scope module: :v1, constraints: Dradis::API::RoutingConstraints.new(version: 1, default: true) do
    resources :nodes
  end
end

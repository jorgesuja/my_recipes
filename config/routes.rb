Rails.application.routes.draw do

  resources :ingredients
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  scope module: :v1, constraints: ApiVersion.new('v1', true) do
    resources :recipes
  end
end

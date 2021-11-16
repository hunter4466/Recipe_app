Rails.application.routes.draw do
  get 'recipes/new'
  get 'recipes/show', to:  "recipes#show", as: "recipes_show"
  delete "/users/recipes/:id", to: "recipes#destroy", as: "user_destroy_recipe"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

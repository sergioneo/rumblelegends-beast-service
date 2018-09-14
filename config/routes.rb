Rails.application.routes.draw do

  get 'beast/marketplace', to: "marketplace#get"

  get 'beast/:id', to: "detail#get_beast"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

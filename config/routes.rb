Rails.application.routes.draw do

  get 'beast/:id', to: "detail#get_beast"

  get 'marketplace/get_beasts', to: "marketplace#get"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

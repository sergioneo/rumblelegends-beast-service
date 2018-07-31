class MarketplaceController < ApplicationController
  def get

  	number_per_page = 10

  	beasts = Array.new

    example_beast = {
      "name": "Pepito",
      "other_attr": 3,
      "likes": 23
    }

    beast_image = "https://image-generator-beta.herokuapp.com/dinosaur/590295810358705651712"

  	(1..number_per_page).each do |i|
  		beast_card = (render_to_string partial: "templates/beast_card", locals: {:beast => example_beast, :image_url => beast_image})
  		pricing_url = "SOME_URL"
  		beasts << {:card => beast_card, :pricing => pricing_url}
  	end

  	render json: beasts

  end
end

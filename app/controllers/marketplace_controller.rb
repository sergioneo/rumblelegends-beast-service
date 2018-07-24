class MarketplaceController < ApplicationController
  def get

  	number_per_page = 10

  	beasts = Array.new

  	(1..number_per_page).each do |i|
  		beast_card = (render_to_string partial: "templates/beast_card")
  		pricing_url = "SOME_URL"
  		beasts << {:card => beast_card, :pricing => pricing_url}
  	end

  	render json: beasts

  end
end

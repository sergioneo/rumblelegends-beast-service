class MarketplaceController < ApplicationController
  def get

    require 'json'

  	number_per_page = 10

    query_url = ENV["INFORMATION_SERVICE"]+'query'
    query_result = JSON.parse(Typhoeus.get(query_url, followlocation: true).body)
    image_base_url = ENV["IMAGE_GENERATION_SERVICE"]

    beast_type_strings = {"0" => "dinosaur", "1" => "unicorn"}

  	beasts = Array.new

    query_result.each do |beast|
      puts beast
      beast_type_string = beast_type_strings[beast["beast_type"].to_s]
      image_url = image_base_url+beast_type_string+"/"+beast["genes"]
  		beast_card = (render_to_string partial: "templates/beast_card", locals: {:beast => beast, :image_url => image_url})
  		pricing_url = ENV["PRICING_SERVICE"]+"beast/"+beast["external_id"].to_s
  		beasts << {:card => beast_card, :pricing => pricing_url}
  	end

  	render json: beasts

  end
end

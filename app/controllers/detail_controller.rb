class DetailController < ApplicationController
  def get_beast

  	beast_type_strings = {"0" => "dinosaur", "1" => "unicorn"}
  	image_base_url = ENV["IMAGE_GENERATION_SERVICE"]

  	query_url = ENV["INFORMATION_SERVICE"]+'beast/'+params[:id]
  	beast = JSON.parse(Typhoeus.get(query_url, followlocation: true).body)
  	beast_type_string = beast_type_strings[beast["beast_type"].to_s]
  	image_url = image_base_url+beast_type_string+"/"+beast["genes"]
	pricing_url = ENV["PRICING_SERVICE"]+"beast/"+beast["external_id"].to_s
  	beast[:pricing] = pricing_url
  	beast[:image_url] = image_url

  	query_url_sire = ENV["INFORMATION_SERVICE"]+'beast/'+beast["sireId"].to_s
  	query_url_matron = ENV["INFORMATION_SERVICE"]+'beast/'+beast["matronId"].to_s

  	sire = JSON.parse(Typhoeus.get(query_url_sire, followlocation: true).body)
  	matron = JSON.parse(Typhoeus.get(query_url_matron, followlocation: true).body)

    if beast["generation"] != 0

    	beast[:sire] = sire
    	beast[:sire][:image_url] = image_base_url+beast_type_string+"/"+sire["genes"].to_s
    	beast[:matron] = matron
    	beast[:matron][:image_url] = image_base_url+beast_type_string+"/"+sire["matron"].to_s

    end

  	render json: beast
  end
end

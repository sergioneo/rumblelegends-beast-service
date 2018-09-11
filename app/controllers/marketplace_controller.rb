class MarketplaceController < ApplicationController
  def get

    require 'json'

  	number_per_page = "10"
    unless params["amountPerPage"].blank?
      number_per_page = params["amountPerPage"]
    end

    page = 1
    unless params["page"].blank?
      page = params["page"].to_i
    end

    offset = (page - 1) * number_per_page.to_i

    start = "0"
    unless params["start"].blank?
      start = params["start"]
    end

    orderBy = "external_id"
    unless params["orderBy"].blank?
      orderBy = params["orderBy"]
    end

    asc = "ASC"
    unless params["asc"].blank?
      asc = params["asc"]
    end


    query_url = ENV["INFORMATION_SERVICE"]+'query?limit='+number_per_page+"&offset="+offset.to_s+"&start="+start+"&orderBy="+orderBy+"&asc="+asc
    query_result = JSON.parse(Typhoeus.get(query_url, followlocation: true).body)
    image_base_url = ENV["IMAGE_GENERATION_SERVICE"]

    beast_type_strings = {"0" => "dinosaur", "1" => "unicorn"}

    return_payload = Hash.new

    return_payload["found"] = query_result["found"]

  	beasts = Array.new

    query_result["hits"].each do |beast|
      beast_type_string = beast_type_strings[beast["beast_type"].to_s]
      image_url = image_base_url+beast_type_string+"/"+beast["genes"]
  		pricing_url = ENV["PRICING_SERVICE"]+"beast/"+beast["external_id"].to_s
      beast[:pricing] = pricing_url
      beast[:image_url] = image_url
  		beasts << beast
  	end

    return_payload["hits"] = beasts

  	render json: return_payload

  end
end

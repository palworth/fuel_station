class SearchController < ApplicationController
  def index
    # location = params['location']
    #
    # api_key = ENV['api_key']
    # search_params = "1331 17th St LL100, Denver, CO 80202"
    # conn = Faraday.new(url: "https://developer.nrel.gov")
    #
    # response = conn.get("/api/alt-fuel-stations/v1/nearest.json?fuel_type_code=ELEC&api_key=AvhDuTdFbHPGJ9v7s6qGcxfU0nEZDRtMq7hfYP2U&location=1331 17th St LL100, Denver, CO 80202")
    # # response = conn.get("/api/v1/nearest.json?fuel_type_code=ELEC&api_key=#{api_key}&location=#{search_params}") do |faraday|
    #   # faraday.params["api_key"] = 'AvhDuTdFbHPGJ9v7s6qGcxfU0nEZDRtMq7hfYP2U'
    #   # faraday.params["fuel_type_code"] = 'ELEC'
    #   # faraday.params['location'] = "#{location}"
    # # end
    #
    # json = JSON.parse(response.body, symbolize_names: true)
    # street_address = json[:fuel_stations][0][:street_address]
    # city = json[:fuel_stations][0][:city]
    # state = json[:fuel_stations][0][:state]
    # zip = json[:fuel_stations][0][:zip]
    # @station_address = "#{street_address}, #{city}, #{state} #{zip}"
nrel_response
google_response

  end

  def nrel_response
    conn = Faraday.new(url: "https://developer.nrel.gov")

    response = conn.get("/api/alt-fuel-stations/v1/nearest.json?fuel_type_code=ELEC&api_key=AvhDuTdFbHPGJ9v7s6qGcxfU0nEZDRtMq7hfYP2U&location=1331 17th St LL100, Denver, CO 80202")

    json = JSON.parse(response.body, symbolize_names: true)
    street_address = json[:fuel_stations][0][:street_address]
    city = json[:fuel_stations][0][:city]
    state = json[:fuel_stations][0][:state]
    zip = json[:fuel_stations][0][:zip]
    @name = json[:fuel_stations][0][:station_name]
    @station_address = "#{street_address}, #{city}, #{state} #{zip}"
  end

  def google_response
    conn = Faraday.new(url: "https://maps.googleapis.com")
    response = conn.get("/maps/api/directions/json?origin=1331 17th St LL100, Denver, CO 80202&destination=1225 17th St., Denver, CO 80202&key=AIzaSyDe0M5Ui5_Yua49xhaeaKbV_Vf7UQyBBWE")

    json = JSON.parse(response.body, symbolize_names: true)
    directions = json[:routes][0][:legs][0][:steps].map do |step|
     step[:html_instructions]
    end
    # require "pry"; binding.pry
    @steps = directions

  end
end

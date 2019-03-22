require 'rest-client'

class API
   
   def self.get_request (endpoint, query)
      url = "https://www.triposo.com/api/20181213/#{endpoint}.json?#{query}"
      headers = {
         'X-Triposo-Account': ENV['API_USER'],
         'X-Triposo-Token': ENV['API_KEY']
      }
      # byebug
      response = RestClient.get(url, headers)
      
      [response.code, JSON.parse(response.body)]
   end
end
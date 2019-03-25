module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :all_user_trips, [TripType], null: false,
      description: "All trips from user"
    field :user, [UserType], null:false,
      description: "Return user from id"
    field :places, [PlaceType], null:false do
      argument :city, String, required: true
    end
    field :city, [CityType], null:false do 
      argument :term, String, required:true
    end
    field :tags, [TagType], null:false do
      argument :city, String, required:true
    end

    def all_user_trips
      user = User.find_by(id: context[:current_user])
      user.trips
    end

    def user
      user = User.find_by(id: context[:current_user])
      user
    end

    def places(city:null)
    endpoint = 'poi'
    query = "trigram=>=0.3&location_id=#{city}&count=10&fields=id,name,score,snippet,location_id,tag_labels&order_by=-score"

    resp = API.get_request(endpoint, query)
    resp[1]['results']
    end

    def city(term:null)
    endpoint = 'location'
    query = "tag_labels=city&annotate=trigram:#{term}&trigram=>=0.4&count=10&fields=id,name,score,country_id,parent_id,snippet,images&order_by=-trigram"

    resp = API.get_request(endpoint, query)
    
    resp[1]['results']
    end

    def tags(city:null)
    endpoint = 'tag'
    offset = 0
    query = "location_id=#{city}&order_by=-score&count=100&offset=#{offset}"
    final_resp = []
    resp = API.get_request(endpoint, query)
    final_resp.push(resp[1]['results'])
    until !resp[1]['more']
      offset = offset + 100
      query = "location_id=#{city}&order_by=-score&count=100&offset=#{offset}"

      resp = API.get_request(endpoint, query)
      final_resp.push(resp[1]['results'])
      byebug
      p 'eol'
    end 

    final_resp.flatten
    end

  end
end

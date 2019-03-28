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
      argument :tags, [String], required: true
    end

    field :city, [CityType], null:false do 
      argument :term, String, required:true
    end

    field :tags, [TagType], null:false do
      argument :city, String, required:true
    end

    field :trip, TripType, null:false do
      argument :trip_id, String, required: true
    end

    def trip(id)
      selected_trip = Trip.find_by(id: id[:trip_id])
      places = selected_trip.places
      places_results = []

      places.map{|place| places_results.push(run_query(place.place_id)) }

      {
        id: selected_trip.id,
        title: selected_trip.title,
        mood: selected_trip.mood,
        number_people: selected_trip.number_people,
        begin_date: selected_trip.begin_date,
        end_date: selected_trip.end_date,
        places: places_results,
      }
    end

    def all_user_trips
      user = User.find_by(id: context[:current_user])
      user.trips
    end

    def user
      user = User.find_by(id: context[:current_user])
      user
    end

    def places(city:null, tags:null)
    endpoint = 'poi'
    tags_array = parse_tags(tags)
    offset = 0
    final_resp = []
    query = "location_id=#{city}&count=100&fields=id,name,score,snippet,location_id,coordinates,images,intro&fields=all&order_by=-score#{tags_array}"

    resp = API.get_request(endpoint, query)
    final_resp.push(resp[1]['results'])

    until !resp[1]['more']
      offset = offset + 100
      query = "location_id=#{city}&count=100&fields=id,name,score,snippet,location_id,coordinates,images,intro&fields=all&order_by=-score#{tags_array}&offset=#{offset}"

      resp = API.get_request(endpoint, query)
      final_resp.push(resp[1]['results'])
    end 
    
    final_resp.flatten
    end

    def city(term:null)
    endpoint = 'location'
    query = "tag_labels=city&annotate=trigram:#{term}&trigram=>=0.4&count=10&fields=id,name,score,country_id,parent_id,snippet,images&order_by=-trigram"

    resp = API.get_request(endpoint, query)
    
    flatten_results = resp[1]['results'].map{|result| flatten_hash(result)}
    byebug
    flatten_results
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
    end 
    final_resp.flatten
    end

    private

    def parse_tags(tags_array)
      tags = []

      tags_array.map{|tag| tags.push("&tag_labels=#{tag}")}

      tags.join
    end

    def run_query(id)
      endpoint = 'poi'
      query = "id=#{id}"
      API.get_request(endpoint, query)
    end

    def flatten_hash(hash)
      hash.each_with_object({}) do |(k, v), h|
        if v.is_a? Hash
          flatten_hash(v).map do |h_k, h_v|
            h["#{k}.#{h_k}".to_sym] = h_v
          end
        else 
          h[k] = v
        end
       end
    end
  end
end

require 'search_object/plugin/graphql'

class Resolvers::TripsSearch
   include SearchObject.module(:graphql)

   scope { Trip.all}

   type types[Types::TripType]

   class TripFilter < Types::BaseInput
      argument :token, String, required: true
   end

   option :token_id, type TripFilter, with :filter_trips

   def filter_trips
      user = GraphqlController.current_user
      user.trips
   end

   
end
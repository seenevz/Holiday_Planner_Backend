module Mutations
   class CreateTrip < BaseMutation
      
      
      class PlaceAttributes < Types::BaseInputObject
         argument :place_id, ID, required: true
         argument :name, String, required: true
      end

      class TripAttributes < Types::BaseInputObject
         argument :title, String, required: true
         argument :mood, String, required: true
         argument :number_people, String, required: true
         argument :begin_date, String, required: true
         argument :end_date, String, required: true
         argument :places, [PlaceAttributes], required: false
      end


      argument :fields, TripAttributes, required: true
      type Types::TripType


      def resolve(fields:null)
         user = context[:current_user]

         trip = user.trips.build(title:fields.title, mood:fields.mood, number_people:fields.number_people, begin_date: fields.begin_date, end_date: fields.end_date)
         begin 
            trip.save
            places = []
            fields.places.map{|place| places.push({place_id: place.place_id, name: place.name, trip_id:trip.id})}
            create_places = Place.create!(places)
         rescue
         end
         trip
      end
   end
end
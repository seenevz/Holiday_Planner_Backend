module Mutations
   class CreatePlace < BaseMutation
      
      
      
      argument :place_id, String, required: true
      argument :name, String, required: true
      argument :trip_id, String, required:true
      


      type Types::PlaceType


      def resolve(place_id:null, name:null, trip_id:null)
         user = context[:current_user]
         trip = user.trips.where(id: trip_id)[0]
         place = Place.new(place_id:place_id, name:name, trip_id: trip.id)

         if place.save!
            place
         else
            {errors: place.errors.full_messages}
         end
       
      end
   end
end
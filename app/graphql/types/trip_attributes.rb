module Types
   class TripAttributes < Types::BaseInputObject
      argument :mood, String, required: true
      argument :number_people, Integer, required: true
      argument :begin_date, String, required: true
      argument :end_date, String, required: true
      argument :places, [Types::PlaceType], required: false
   end
end
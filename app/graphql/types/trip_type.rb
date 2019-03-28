module Types
   class TripType < BaseObject      
      field :id, ID, null: false
      field :title, String, null: false
      field :mood, String, null: true
      field :number_people, Integer, null: true
      field :begin_date, String, null: true
      field :end_date, String, null: true
      field :places, [Types::PlaceType], null: true
   end
end
module Types
   class TripType < BaseObject      
      field :id, ID, null: false
      field :city, String, null: false
      field :mood, String, null: true
      field :number_people, Integer, null: true
      field :begin_date, String, null: true
      field :end_date, String, null: true
   end
end
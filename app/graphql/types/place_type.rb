module Types
   class PlaceType < BaseObject      
      field :id, ID, null: true
      field :place_id, String, null:true
      field :city, String, null: true
      field :mood, String, null: true
      field :number_people, Integer, null: true
      field :begin_date, String, null: true
      field :end_date, String, null: true
   end
end
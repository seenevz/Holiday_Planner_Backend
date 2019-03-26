module Types
   class PlaceType < BaseObject      
      field :id, ID, null: true
      field :name, String, null:true
      field :coordinates, CoordinatesType, null:true
      field :intro, String, null:true
      field :snippet, String, null:true
      field :score, String, null:true
      field :location_id ,String, null:true
      field :images, [ImageType], null:true
   end
end
module Types
   class CityType < BaseObject      
      field :id, String, null: true
      field :name, String, null:true
      field :snippet, String, null: true
      field :trigram, String, null: true
      field :parent_id, String, null: true
      field :score, String, null: true
      field :country_id, String, null: true
      field :images, [ImageType], null: true
   end
end
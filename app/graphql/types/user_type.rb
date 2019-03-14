module Types
   class UserType < BaseObject
      argument :id, ID, required: false

      field :id, ID, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
   end
end
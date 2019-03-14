module Mutations
   class CreateUser < Mutations::BaseMutation
      argument :first_name, String, required: true
      argument :last_name, String, required: true

      type Types::UserType

      def resolve(first_name: nil, last_name: nil)
         User.create!(
            first_name: first_name,
            last_name: last_name,
         )
      end

   end
end
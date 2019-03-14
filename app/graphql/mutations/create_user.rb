module Mutations
   class CreateUser < Mutations::BaseMutation

      class AuthProviderSignupData < Types::BaseInputObject
         argument :credentials, Types::AuthProviderEmail, required: false
       end

      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :auth_provider, AuthProviderSignupData, required: false

      type Types::UserType

      def resolve(first_name: nil, last_name: nil, auth_provider: nil)
         User.create!(
            first_name: first_name,
            last_name: last_name,
            email: auth_provider&.[](:email)&.[](:email),
            password: auth_provider&.[](:email)&.[](:password),
         )
      end

   end
end
module Mutations
   class CreateUser < Mutations::BaseMutation

      class AuthProviderSignupData < Types::BaseInputObject
         argument :credentials, Types::AuthProviderCredentials, required: false
       end
 
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :currency, String, required: false
      argument :auth_provider, AuthProviderSignupData, required: false

      type Types::UserType

      def resolve(first_name: nil, last_name: nil, currency: nil, auth_provider: nil)
         User.create!(
            first_name: first_name,
            last_name: last_name,
            currency: currency,
            email: auth_provider[:credentials][:email],
            password: auth_provider[:credentials][:password],
         )
      end
   end
end
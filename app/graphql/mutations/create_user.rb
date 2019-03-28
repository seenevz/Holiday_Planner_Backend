module Mutations
   class CreateUser < Mutations::BaseMutation

      class AuthProviderSignupData < Types::BaseInputObject
         argument :credentials, Types::AuthProviderCredentials, required: false
       end
 
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :currency, String, required: false
      argument :auth_provider, AuthProviderSignupData, required: false

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(first_name: nil, last_name: nil, currency: nil, auth_provider: nil)
         user = User.create!(
            first_name: first_name,
            last_name: last_name,
            currency: currency,
            email: auth_provider[:credentials][:email],
            password: auth_provider[:credentials][:password],
         )
         
         token = issue_token({id: user.id})
         context[:session][:authorization] = token
         byebug
         { user: user, token: token }
      end
   end
end
module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser,
      description: "Add user to database"
    field :signin_user, mutation: Mutations::SignInUser,
      description: "Sign in user"
  end
end

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser,
      description: "Add user to database"
    field :signin_user, mutation: Mutations::SignInUser,
      description: "Sign in user"
    field :create_trip, mutation: Mutations::CreateTrip,
      description: "Create a trip"
    field :create_place, mutation: Mutations::CreatePlace
  end
end

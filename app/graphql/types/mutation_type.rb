module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser,
      description: "Add user to database"
  end
end

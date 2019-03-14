module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :all_users, [UserType], null: false,
      description: "All users stored"
    field :user, [UserType], null:false,
      description: "Return user from id"

    def all_users
      User.all
    end

    def user (id)
      User.find(id)
    end
  end
end

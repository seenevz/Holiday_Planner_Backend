module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :all_user_trips, [TripType], null: false,
      description: "All trips from user"
    field :user, [UserType], null:false,
      description: "Return user from id"

    def all_user_trips
      user = User.find_by(id: context[:current_user])
      user.trips
    end
  end
end

module Mutations
   class CreateTrip < BaseMutation
      
      argument :city, String, required: true
      argument :mood, String, required: true
      argument :number_people, Integer, required: true
      argument :begin_date, String, required: true
      argument :end_date, String, required: true

      type Types::TripType

      # field :trip, Types::TripType, null: false

      def resolve(city: nil, mood: nil, number_people: nil, begin_date: nil, end_date: nil)
         Trip.create!(
            city: city,
            mood: mood,
            number_people: number_people,
            begin_date: begin_date,
            end_date: end_date,
            user: context[:current_user]
         )
      end
   end
end
module Mutations
   # This class is used as a parent for all mutations, and it is the place to have common utilities 
   class BaseMutation < GraphQL::Schema::Mutation
     null false

     def issue_token(data)
      JWT.encode(data, secret)
    end
  
    def get_current_user
      id = decoded_token['id']
      User.find_by(id: id)
    end
  
    def decoded_token
      token = request.headers['Authorization']
      begin
        JWT.decode(token, secret).first
      rescue
        {}
      end
    end
  
    def secret
      ENV['MY_SUPER_MEGA_SECRET']
    end
   end
 end
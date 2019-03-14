class User < ApplicationRecord
   has_secure_password

   has_many :trips

   validates :first_name, :last_name, presence: true
   validates :email, presence: true, uniqueness: true
end

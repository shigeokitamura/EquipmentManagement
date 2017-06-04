ActiveRecord::Base.establish_connection(ENV['DATABASE_URL']||"sqlite3:db/development.db")
class Contribution < ActiveRecord::Base
end

class User < ActiveRecord::Base
  has_secure_password
  validates :mail,
    presence: true,
  format: {with:/.+@.+/}
    validates :password,
    length: {in: 5..10}
end

class Rental < ActiveRecord::Base
end

class Purchaselist < ActiveRecord::Base
end

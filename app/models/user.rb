class User < ApplicationRecord
    # Using scope and lambda
    scope :search, -> (key) { User.where("firstName LIKE ? or lastName LIKE ? or email LIKE ?", "%"+key+"%", "%"+key+"%", "%"+key+"%") }

    # Using method
    # def self.search(key)
    #     User.where("firstName LIKE ? or lastName LIKE ? or email LIKE ?", "%"+key+"%", "%"+key+"%", "%"+key+"%")
    # end
end
class User < ActiveRecord::Base
    has_many :posts
    has_secure_password
    validates :email, presence: true, uniqueness: true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
    validates_length_of :password, minimum: 8
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  USERS_PARAMS = %i(email password password_confirmation).freeze

  validates :email, presence: true,
    length: {minimum: Settings.validations.user.email.minimum,
            maximum: Settings.validations.user.email.maximum},
    uniqueness: {case_sensitive: false},
    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}

  validates :password, presence: true,
  length: {minimum: Settings.validations.user.password.minimum,
          maximum: Settings.validations.user.password.maximum}
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  email_regex = /^([^@\s]+)@(tre-sp.gov.br||wm.tre-sp.gov.br)$/i

  validates :email, :format => { :with => email_regex }, :allow_blank => true
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end

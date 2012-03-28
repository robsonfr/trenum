# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)     default(""), not null
#  encrypted_password     :string(128)     default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  failed_attempts        :integer         default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  admin                  :boolean         default(FALSE)
#  name                   :string(255)
#  workplace              :string(255)
#

class User < ActiveRecord::Base
  has_many :documents
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  # Só emails do TRE-SP
  email_regex = /^([^@\s]+)@(tre-sp.gov.br||wm.tre-sp.gov.br)$/i
  # Qualquer email
  # email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, :format => { :with => email_regex }
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :workplace, :admin
end

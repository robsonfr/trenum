# == Schema Information
#
# Table name: documents
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  type            :string(255)
#  subject         :string(255)
#  recipient       :string(255)
#  dispatch_number :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Document < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :type, :subject, :recipient, :dispatch_number
end

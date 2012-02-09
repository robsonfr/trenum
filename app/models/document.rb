# == Schema Information
#
# Table name: documents
#
#  id              :integer         not null, primary key
#  user_id         :integer
#  doctype         :string(255)
#  subject         :string(255)
#  recipient       :string(255)
#  dispatch_number :integer
#  created_at      :datetime
#  updated_at      :datetime
#  status          :string(255)
#  pdf_file        :string(255)
#

class Document < ActiveRecord::Base
  belongs_to :user
  mount_uploader :pdf_file, PdfFileUploader
  validates :doctype, :subject, :recipient, :presence => true
  validates_uniqueness_of :dispatch_number, :scope => :doctype
  attr_accessible :user_id, :doctype, :subject, :recipient, :dispatch_number, :status, :pdf_file
end

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

require File.dirname(__FILE__) + '/../spec_helper'

describe Document do
  it "should be valid" do
    Document.new.should be_valid
  end
end

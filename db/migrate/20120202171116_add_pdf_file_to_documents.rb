class AddPdfFileToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :pdf_file, :string
  end

  def self.down
    remove_column :documents, :pdf_file
  end
end

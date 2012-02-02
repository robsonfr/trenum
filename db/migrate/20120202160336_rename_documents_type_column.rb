class RenameDocumentsTypeColumn < ActiveRecord::Migration
  def self.up
  	rename_column :documents, :type, :doctype
  end

  def self.down
  	rename_column :documents, :doctype, :type
  end
end

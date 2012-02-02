class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.integer :user_id
      t.string :type
      t.string :subject
      t.string :recipient
      t.integer :dispatch_number
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end

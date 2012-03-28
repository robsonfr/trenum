class AddNameAndWorkplaceToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :workplace, :string
  end

  def self.down
    remove_column :users, :workplace
    remove_column :users, :name
  end
end

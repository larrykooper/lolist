class AddForSe < ActiveRecord::Migration
  def self.up
    add_column :items, :short_task_name, :string
    add_column :items, :swiss_cheese, :string
    add_column :items, :out_indicator, :boolean
  end

  def self.down
    remove_column :items, :short_task_name 
    remove_column :items, :swiss_cheese 
    remove_column :items, :out_indicator 
  end
end

class InitialSchema < ActiveRecord::Migration
  def self.up
      
      create_table "items" do |t|
        t.column "create_date",     :datetime,                              :null => false
        t.column "number",          :integer,  :limit => 5, :default => 0,  :null => false
        t.column "act_type",        :string,   :limit => 5, :default => "", :null => false
        t.column "item_desc",       :text,                  :default => "", :null => false
        t.column "value_when_done", :string
        t.column "where_to_do",     :string
      end

      create_table "taggings" do |t|
        t.column "tag_id",        :integer, :limit => 10, :default => 0,  :null => false
        t.column "taggable_id",   :integer, :limit => 10, :default => 0,  :null => false
        t.column "taggable_type", :string,                :default => "", :null => false
      end

      create_table "tags" do |t|
        t.column "name",       :string,   :default => "", :null => false
        t.column "created_at", :datetime,                 :null => false
        t.column "updated_at", :datetime,                 :null => false
      end

      create_table "users" do |t|
        t.column "login",    :string, :limit => 80
        t.column "password", :string, :limit => 40
      end
  end

  def self.down
    drop_table :items 
    drop_table :taggings 
    drop_table :tags 
    drop_table :users 
  end
end

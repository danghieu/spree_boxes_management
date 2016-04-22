class AddStatusToBox < ActiveRecord::Migration
  def change
    add_column :boxes,  :is_active, :boolean, :default => true
  end
end

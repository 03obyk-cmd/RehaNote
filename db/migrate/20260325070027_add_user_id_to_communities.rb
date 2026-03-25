class AddUserIdToCommunities < ActiveRecord::Migration[8.0]
  def change
    add_column :communities, :user_id, :integer
  end
end

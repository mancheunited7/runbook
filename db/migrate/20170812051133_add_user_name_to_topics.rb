class AddUserNameToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :user_name, :string
  end
end

# frozen_string_literal: true

class AddProfileFieldsToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :image, :string
    add_column :users, :bio, :text
  end
end

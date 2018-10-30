# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.string :description
      t.integer :favorites_count
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :articles, :slug, unique: true
  end
end

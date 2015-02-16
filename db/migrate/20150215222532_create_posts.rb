class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :author
      t.datetime :created

      t.timestamps
    end
  end
end

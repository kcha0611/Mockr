class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :c_content
      t.integer :answer_id, null: false
      t.integer :user_id 
      t.timestamps null: false
    end
  end
end

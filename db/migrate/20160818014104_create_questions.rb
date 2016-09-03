class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_title, null: false
      t.string :q_content
      t.integer :user_id, null: false
      t.timestamps null: false
    end
  end
end

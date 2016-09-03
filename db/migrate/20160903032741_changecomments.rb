class Changecomments < ActiveRecord::Migration
  def change
  add_column :comments, :question_id, :integer
  remove_column :comments, :answer_id
  end
end

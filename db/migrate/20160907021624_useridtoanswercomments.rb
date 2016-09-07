class Useridtoanswercomments < ActiveRecord::Migration
  def change
    add_column :answercomments, :user_id, :integer
  end
end

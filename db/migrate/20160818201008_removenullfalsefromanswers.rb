class Removenullfalsefromanswers < ActiveRecord::Migration
  def change
    change_column :answers, :question_id, :integer, :null => false
    change_column :answers, :user_id, :integer, :null => false
  end
end

class CreateAnswercomments < ActiveRecord::Migration
  def change
    create_table :answercomments do |t|
      t.integer :answer_id
      t.string :answercomment_content, null: false
      t.timestamps null: false
    end
  end
end

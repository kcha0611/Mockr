class CommentsController < ApplicationController
  before_action :set_question, only: [:new, :create]
  before_action :require_logged_in, only: [:new, :create, :upvote, :downvote]

  def new
    redirect_to '/login' if current_user.nil?
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id if current_user
    @question = Question.find(params[:question_id])
    @comment.question_id = @question.id

      if @comment.save
        redirect_to "/questions/#{@question.id}"
      else
        flash.now[:errors] = @comment.errors.full_messages
        render 'questions/show'
      end
  end

  def index
    @comments = Comment.all
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_from(current_user)
    redirect_to :back
  end

  def downvote
    @comment = Comment.find(params[:id])
    @comment.downvote_from(current_user)
    redirect_to :back
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:c_content, :question_id)
  end

end

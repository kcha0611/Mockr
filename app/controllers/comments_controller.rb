class CommentsController < ApplicationController
  before_action :set_question, only: [:new, :create]
  before_action :require_logged_in

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    # @question = Question.find(params[:question_id])
    @comment.user_id = current_user.id
    # @comment.question_id = @question.id
    @question = Question.find(params[:question_id])
    @comment.question_id = @question.id
    if @comment
      @comment.save!
      redirect_to "/questions/#{@question.id}"
    else
      render json: ["Somethings fucked up"]
    end
  end

  def index
    if params[:user_id]
      @comments = Comment.where(user_id: user_id)
    else
      @comments = Comment.all
    end
  end

  private

  def set_question
    @question = Question.find(params[:question_id])
  end

  def comment_params
    params.require(:comment).permit(:c_content, :question_id)
  end

end

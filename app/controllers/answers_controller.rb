class AnswersController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :upvote, :downvote]
  before_action :set_question, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    @answer.user_id = current_user.id
    @question = Question.find(params[:question_id])
    @answer.question_id = @question.id
    if @answer.save
      redirect_to "/questions/#{@question.id}"
    else
      flash.now[:errors] = @answer.errors.full_messages
      render '/questions/show'
    end
  end

  def index
    if params[:user_id]
      @answers = Answer.where(user_id: user_id)
    else
      @answers = Answer.all
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
  end

  def destroy
  end

  def upvote
    @answer = Answer.find(params[:id])
    @answer.upvote_from(current_user)
    redirect_to :back
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.downvote_from(current_user)
    redirect_to :back
  end

  private
  def set_question
      @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:a_content, :question_id)
  end

end

class AnswersController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]
  before_action :set_question, only: [:new, :create]

  def new
    @answer = Answer.new
  end

  def create
    @answer = Answer.new(answer_params)
    debugger
    @answer.user_id = current_user.id
    @answer.question_id = @question.id
    if @answer
      @answer.save!
      redirect_to "/questions/#{@question.id}"
    else
      render json: ["somethings fucked up"]
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

  private
  def set_question
    if @question.nil?
      @question = Question.find(params[:id]) if @question.nil?
    elsif
      @question = Question.find(params[:question_id])
    end
  end

  def upvote
    @answer = Answer.find(params[:answer_id])
    @question = Question.find(params[:question_id])
    @vote = Vote.find_by(answer_id: @answer.id, user_id: current_user.id)

    if @vote.nil?
      @answer.votes.create!(user_id: current_user.id, answer_id: @answer.id, value: 1)
    elsif @vote && @question.votes.all? {|vote| vote.user_id != current_user.id}
      @vote.update(value: (@vote.value += 1))
    end

    redirect_to :back
  end

  def answer_params
    params.require(:answer).permit(:a_content, :question_id, :user_id)
  end

end

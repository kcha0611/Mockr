class AnswercommentsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create]
  before_action :set_answer, only: [:new, :create]

  def new
  end

  def create
    @answercomment = Answercomment.new(answercomment_params)
    @answercomment.answer_id = @answer.id
    if @answercomment.save
      redirect_to "/questions/#{@answer.question_id}"
    else
      flash.now[:errors] = @answercomment.errors.full_messages
      render :new
    end
  end

  def index
    @answercomments = Answercomment.all
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def answercomment_params
    params.require(:answercomment).permit(:answercomment_content, :answer_id)
  end

end

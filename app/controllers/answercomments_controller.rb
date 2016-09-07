class AnswercommentsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :upvote, :downvote]
  before_action :set_answer, only: [:new, :create]

  def new
  end

  def create
    @answercomment = Answercomment.new(answercomment_params)
    @answercomment.answer_id = @answer.id
    @answercomment.user_id = current_user.id
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

  def upvote
    @answercomment = Answercomment.find(params[:id])
    @answercomment.upvote_from(current_user)
    redirect_to :back
  end

  def downvote
    @answercomment = Answercomment.find(params[:id])
    @answercomment.downvote_from(current_user)
    redirect_to :back
  end

  private

  def set_answer
    @answer = Answer.find(params[:answer_id])
  end

  def answercomment_params
    params.require(:answercomment).permit(:answercomment_content, :answer_id)
  end

end

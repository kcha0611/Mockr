class QuestionsController < ApplicationController
  before_action :require_logged_in, only: [:new, :create, :edit, :update, :upvote, :downvote]
  before_action :set_question, only: [:show, :upvote, :downvote]

  def new
    if current_user.nil?
      redirect_to '/login'
    end
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      redirect_to "/questions"
    else
      flash.now[:errors] = @question.errors.full_messages
      render :new
    end
  end

  def index
    @rand_questions = []
    @pop_questions = []
    @unanswered_questions = []
    @questions = Question.all
      @questions.each do |question|
        if question.subject == "random" || question.subject == "Random"
          @rand_questions.push(question)
        end
        if (question.get_upvotes.size - question.get_downvotes.size) >= 1
          @pop_questions.push(question)
        end
        if question.answers.length == 0
          @unanswered_questions.push(question)
        end
      end
    @rand_questions
    @pop_questions
    @unanswered_questions
  end

  def upvote
    redirect_to '/login' if current_user.nil?
    @question.upvote_from(current_user)
    redirect_to :back
  end

  def downvote
    @question.downvote_from(current_user)
    redirect_to :back
  end

  def show
    @question = Question.find_by_id(params[:id])
    @answer = Answer.new if @answer.nil?
    @answer = Answer.find_by(question_id: @question.id, user_id: @question.user.id)
  end

  private
  def question_params
    params.require(:question).permit(:q_title, :q_content, :user_id, :subject, :vote, :answers)
  end

  def set_question
    @question = Question.find_by_id(params[:id])
  end

end

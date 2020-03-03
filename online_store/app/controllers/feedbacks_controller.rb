class FeedbacksController < ApplicationController
  before_action :set_user
  def new
    if current_user.nil?
      @feedback=@guest.feedbacks.build
    else
      @feedback=current_user.feedbacks.build
    end

  end

  def show
    @feedbacks=Feedback.all
  end

  def create
    if current_user.nil?
      @feedbacks = @guest.feedbacks.build(feedback_params)
    else
      @feedbacks = current_user.feedbacks.build(feedback_params)
    end

    respond_to do |format|
      if @feedbacks.save
        format.html { redirect_to root_path, notice: 'Thank you for the feedback' }
        format.json { render :show, status: :created, location: @feedbacks }
      else
        format.html { render :new }
        format.json { render json: @feedbacks.errors, status: :unprocessable_entity }
      end
    end
  end

  def feedback_params
    params.require(:feedback).permit(:message)
  end

  def set_user()
    if current_user.nil?
      @guest=User.find(2)
    end
  end
end

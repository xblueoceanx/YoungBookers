class ReviewersController < ApplicationController
     before_action :authenticate_reviewer!

  def index
    @reviews = Review.all
    @review = Review.new
    @reviewers = Reviewer.all
    @reviewer = Reviewer.find(current_reviewer.id)
  end

  def show
  	@reviewer = Reviewer.find(params[:id])
  	@review = Review.new
    @reviews = @reviewer.reviews
  end

  def edit
  	@reviewer = Reviewer.find(params[:id])
    if @reviewer == current_reviewer
    else
      redirect_to reviewer_path(current_reviewer)
    end
  end

  def info
  	@reviewer = Reviewer.find(params[:id])
  end

  def update
    reviewer = Reviewer.find(params[:id])
    if reviewer.update(reviewer_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to reviewer_path(reviewer)
    else
      @reviewer = reviewer
      render :edit
    end
  end

  private
  def reviewer_params
   params.require(:reviewer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :telephone_number, :encrypted_password, :profile_image )
  end
  
end

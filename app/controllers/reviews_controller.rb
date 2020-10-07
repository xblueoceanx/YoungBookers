class ReviewsController < ApplicationController
  before_action :authenticate_reviewer!

  def top
  end

  def new
    @review = Review.new
  end

  def create
    @reviews = Review.all
    @review = Review.new(review_params)
    @review.reviewer_id = current_reviewer.id
    if @review.save
      flash[:notice] = "You have creatad book successfully."
      redirect_to review_path(@review)
    else
     @reviewer = current_reviewer
     render :new
    end
  end

  def index
    @reviews = Review.all
    @review = Review.new
    @reviewer = Reviewer.find(current_reviewer.id)
    @all_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(3).pluck(:review_id))
  end

  def show
    @review = Review.find(params[:id])
    @review_new = Review.new
    @reviewer = @review.reviewer
    @all_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(3).pluck(:review_id))
  end

  def edit
    @review = Review.find(params[:id])
    if @review.reviewer == current_reviewer
    else
      redirect_to reviews_path
    end
  end

  def update
    review = Review.find(params[:id])
    if review.update(review_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to review_path(review)
    else
      @review = review
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:title, :book_review, :user_id, :reviewer_id)
  end

end

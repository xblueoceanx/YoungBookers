class ReviewersController < ApplicationController
     before_action :authenticate_reviewer!

  def index
    @reviews = Review.all
    @review = Review.new
    @reviewers = Reviewer.all
    @reviewer = Reviewer.find(current_reviewer.id)
    @all_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(3).pluck(:review_id))
  end

  def show
    @reviewer = Reviewer.find(params[:id])
    @review = Review.new
    @reviews = @reviewer.reviews
    @all_ranks = Review.find(Favorite.group(:review_id).order('count(review_id) desc').limit(3).pluck(:review_id))
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
    begin
      ActiveRecord::Base.transaction do
        if reviewer.update(reviewer_params)
          result = Vision.get_image_data(reviewer.profile_image)
          if result.values.include?("LIKELY") || result.values.include?("VERY_LIKELY")
            raise 'invalid image'
          end

          flash[:notice] = "アップデートが成功しました"
          redirect_to reviewer_path(reviewer)
        else
          @reviewer = reviewer
          flash[:alert] = "アップデートが失敗しました"
          render :edit
        end
      end
    rescue
      @reviewer = reviewer
      flash[:alert] = "画像が不適切な可能性があります"
      render :edit
    end
  end

  private
  def reviewer_params
   params.require(:reviewer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :telephone_number, :encrypted_password, :profile_image )
  end

end

class User::ReviewsController < UserController
  before_action :set_product_params, only: %i[new create edit update destroy] # to get the id of the product
  before_action :set_review_params, only: %i[edit update destroy] # and this one for the review id

  def new
    @review = @product.reviews.build
  end

  def edit; end

  def create
    @review = @product.reviews.create(review_params)

    if @review.save
      redirect_to user_product_path(@product), notice: 'Review submitted'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      redirect_to user_product_path(@product), notice: 'Updated review submitted!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy

    redirect_to user_product_path(@product), notice: 'Review is deleted'
  end # To Add

  private

  def set_product_params
    @product = Product.find(params[:product_id])
  end

  def set_review_params
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    # TODO: params for review
    params.require(:review).permit(:user_id, :rating, :title, :description) # ReviewStarRating, ReviewTitle, & ReviewDescription
  end
end

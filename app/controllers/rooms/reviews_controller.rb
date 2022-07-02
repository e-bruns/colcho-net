class Rooms::ReviewsController < ApplicationController
  before_action :require_authentication

  def create
    review = room.reviews.find_or_initialize_by(user_id: :user_id, user_id: current_user.id)
    review.update!(review_params)

    head :ok
  end

  def update
    create
  end

  def room
    @room ||= Room.find(params[:room_id])
  end

  private

  def review_params
    params.require(:review).permit(:points, :room_id, :user_id)
  end

end
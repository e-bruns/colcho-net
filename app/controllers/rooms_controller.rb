class RoomsController < ApplicationController
  before_action :require_authentication, only: %i[ new edit create update destroy ]
  
  PER_PAGE = 2

  def index
    # @rooms = Room.most_recent
    @search_query = params[:q]
    rooms = Room.search(@search_query)
    # rooms = Room.search(@search_query).page(params[:page]).per(PER_PAGE)
    # @rooms = RoomCollectionPresenter.new(rooms.most_recent, self)

    @rooms = rooms.most_recent.map do |room|
      RoomPresenter.new(room, self, false)
    end
    @rooms = Kaminari.paginate_array(@rooms).page(params[:page]).per(PER_PAGE)
    
  end

  def show
    # @room = Room.find(params[:id])
    # if user_signed_in?
    #   @user_review = @room.reviews.find_or_initialize_by(user_id: :user_id, user_id: current_user.id)
    # end
    room_model = Room.find(params[:id])
    @room = RoomPresenter.new(room_model, self)
  end

  def new
    @room = current_user.rooms.build
  end

  def edit
    @room = current_user.rooms.find(params[:id])
  end

  def create
    @room = current_user.rooms.build(room_params)
    if @room.save
      redirect_to room_url(@room), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @room = current_user.rooms.find(params[:id])

    if @room.update(room_params)
      redirect_to room_url(@room), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @room = current_user.rooms.find(params[:id])
    @room.destroy

    redirect_to rooms_url, notice: t('.success')
  end

  private
  # Only allow a list of trusted parameters through.
    def room_params
      params.require(:room).permit(:title, :location, :description, :image)
    end
end

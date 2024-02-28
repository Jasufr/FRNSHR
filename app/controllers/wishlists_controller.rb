class WishlistsController < ApplicationController
  def index
    @wishlist = Wishlist.new
    @wishlists = policy_scope(Wishlist)
    @room = Room.find(params[:room_id])
    @wishlists = @wishlists.where(room: @room)
    if params[:query].present?
      # To do: add also Items that matches the room
      @items = Item.search_by_name(params[:query])
    else
      # To do: turn this one into Items that matches the room
      @items = Item.all
    end
  end

  def create
    @wishlist = Wishlist.new(wishlist_params)
    authorize @wishlist
    @room = Room.find(params[:room_id])
    @wishlist.room = @room
    if @wishlist.save
      redirect_to room_wishlists_path(@room)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    authorize @wishlist
    @room = @wishlist.room
    @wishlist.destroy
    redirect_to room_wishlists_path(@room), status: :see_other
  end

  private

  def wishlist_params
    params.require(:wishlist).permit(:item_id)
  end
end

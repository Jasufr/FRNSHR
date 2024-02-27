class WishlistsController < ApplicationController

def index
  @wishlists = policy_scope(Wishlist)
  @room = Room.find(params[:room_id])
  @wishlists = @wishlists.where(room: @room)
  @items = Item.all
end

def create
  @wishlist = Wishlist.new(wishlist_params)
  authorize @wishlist
  @room = Room.find(params[:room_id])
  @wishlist.room = @room
  # if @wishlist.save
  #   redirect_to wishlist_path(@wishlist) - don't redirect, just plop it in the partial
  # else
  #   render :new, status: :unprocessable_entity
  # end
end

def destroy
  @wishlist = Wishlist.find(params[:id])
  @wishlist.destroy
end

private

def wishlist_params
  params.require(:wishlist).permit(:item_id)
end

end

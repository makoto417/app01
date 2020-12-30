class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
    @joinUser = Entry.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @direct_messages = @room.direct_messages
      @direct_message = DirectMessage.new
      @entries = @room.entries.where.not(user_id: current_user.id)
    else
      redirect_back(fallback_locateion: root_path)
    end

    @user = current_user
    @userEntries = @user.entries
    myRoomIds = []
    @userEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id !=?', @user.id)
  end

  private

  def join_room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end

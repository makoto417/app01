class DirectMessagesController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :set_room, only: [:create, :destroy]
  before_action :set_direct_message, only: :destroy

  def create
    if Entry.where(user_id: current_user.id, room_id: @room.id)
      @direct_message = DirectMessage.create(message_params)
      if @direct_message.save
        @direct_message = DirectMessage.new
        gets_entries_all_messages
      end
    else
      flash[:alert] = 'メッセージの送信に失敗しました'
    end
  end

  def destroy
    gets_entries_all_messages if @direct_message.destroy
  end

  private

  def set_room
    @room = Room.find(params[:direct_message][:room_id])
  end

  def set_direct_message
    @direct_message = DirectMessage.find(params[:id])
  end

  def gets_entries_all_messages
    @direct_messages = @room.direct_messages.includes(:user).order(created_at: 'ASC')
    @entries = @room.entries
  end

  def message_params
    params.require(:direct_message).permit(:ures_id, :message, :room_id).merge(user_id: current_user.id)
  end
end

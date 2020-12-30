class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followed, :followers, :recommend]
  before_action :recommend_function, only: [:show, :recommend]

  def index
  end

  def show
    @user = User.find(params[:id])
    @follow_limit = @user.followed.limit(6)
    @consoles = @user.consoles
    @categories = @user.categories

    @userEntries = @user.entries
    myRoomIds = []
    @userEntries.each do |entry|
      myRoomIds << entry.room.id
    end
    @anotherEntries = Entry.where(room_id: myRoomIds).where('user_id !=?', @user.id)
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: @user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id
              @existRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def followed
    @users = @user.followed.page(params[:page]).per(10)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(10)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def recommend_function
    if user_signed_in?
      user = current_user
      userCategories = user.user_category_relations
      myCategoryIds = []
      userCategories.each do |cate|
        myCategoryIds << cate.category.id
      end
      otherUserCategory = UserCategoryRelation.where(category_id: myCategoryIds).where('user_id !=?', user.id)
      otherUserIds = []
      otherUserCategory.each do |cate|
        otherUserIds << cate.user.id
      end
      userConsoles = user.user_console_relations
      myConsoleIds = []
      userConsoles.each do |con|
        myConsoleIds << con.console.id
      end
      otherUserConsole = UserConsoleRelation.where(console_id: myConsoleIds).where('user_id !=?', user.id)
      otherUserConsole.each do |con|
        otherUserIds << con.user.id
      end
      followedIds = user.followed_ids
      otherUserIds -= followedIds
      otherUserIds_uniq = otherUserIds.uniq
      @similar_user_limit = User.where(id: otherUserIds_uniq).limit(5)
      @similar_users = User.where(id: otherUserIds_uniq).page(params[:page]).per(10)
    end
  end
end

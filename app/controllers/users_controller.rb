class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:setting, :nickname]
  before_action :set_user, only: [:show, :recommend]
  before_action :set_current_user, only: [:setting, :nickname, :profile, :gameprofile, :profileimage, :email, :password]
  before_action :recommend_function, except: [:index, :followed, :follower]
  before_action :set_user_edit, only: [:nickname, :profile, :gameprofile, :profileimage, :email, :password]

  def index
    @q = User.ransack(params[:q])
    if user_signed_in?
      @users = User.all.where.not(id: current_user.id).page(params[:page]).per(10)
      @results = @q.result(distinct: true).page(params[:page]).per(10)
    else
      @users = User.all.page(params[:page]).per(10)
      @results = @q.result(distinct: true).page(params[:page]).per(10)
    end
  end

  def show
    @follow_limit = @user.followed.limit(6)
    @consoles = @user.consoles
    @categories = @user.categories

    # roomの相手ユーザーの取得
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

    # 書き込んだ掲示板取得
    @create_boards = @user.boards
    @comments = @user.comments
    myBoardIds = []
    @comments.each do |com|
      myBoardIds << com.board.id
    end
    @write_boards = Board.where(id: myBoardIds)
  end

  def setting
    render layout: 'user_edit'
  end

  def nickname
  end

  def profile
  end

  def gameprofile
  end

  def profileimage
  end

  def email
  end

  def password
  end

  def followed
    @users = @user.followed.page(params[:page]).per(10)
  end

  def followers
    @users = @user.followers.page(params[:page]).per(10)
  end

  def recommend
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_current_user
    @user = current_user
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

  def set_user_edit
    @user = current_user
    render layout: 'user_edit'
  end
end

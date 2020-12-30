class TopController < ApplicationController
  before_action :recommend_function

  def index
    @boards = Board.order(created_at: 'DESC').limit(5)
    @posts = Post.order(created_at: 'DESC').limit(5)
    @user = current_user
    @category_ranks = Category.find(UserCategoryRelation.group(:category_id).order('count(category_id)desc').pluck(:category_id))
  end

  def new_guest
    user = User.find_or_create_by!(nickname: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private
  
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

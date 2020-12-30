class TopController < ApplicationController
  def index
    @boards = Board.order(created_at: 'DESC').limit(5)
    @posts = Post.order(created_at: 'DESC').limit(5)
    @user = current_user
    @category_ranks = Category.find(UserCategoryRelation.group(:category_id).order('count(category_id)desc').pluck(:category_id))
  end
end

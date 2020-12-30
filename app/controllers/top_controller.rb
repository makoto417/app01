class TopController < ApplicationController
  def index
    @user = current_user
    @category_ranks = Category.find(UserCategoryRelation.group(:category_id).order('count(category_id)desc').pluck(:category_id))
  end
end

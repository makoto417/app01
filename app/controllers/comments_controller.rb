class CommentsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @comment = @board.comments.new(params_comment)
    @comment.board = @board
    if @comment.save
      redirect_to board_path(@board)
    else
      redirect_to board_path(@board)
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    comment = @board.comments.find(params[:id])
    if current_user == comment.user
      comment.destroy
      redirect_to board_path(@board)
    end
  end

  private

  def params_comment
    params.require(:comment).permit(:content).merge(user_id: current_user.id)
  end
end

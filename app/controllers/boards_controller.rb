class BoardsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_board, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: :edit

  def index
    @q = Board.ransack(params[:q])
    @boards = Board.all.page(params[:page]).per(20)
    @results = @q.result(distinct: true).page(params[:page]).per(20)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.valid?
      @board.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @board.comments.includes(:user)
  end

  def edit
  end

  def update
    if @board.update(board_params)
      redirect_to board_path
    else
      render :edit
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to root_path
  end

  private

  def board_params
    params.require(:board).permit(:title, :game_id, console_ids: [], category_ids: []).merge(user_id: current_user.id)
  end

  def set_board
    @board = Board.find(params[:id])
  end

  def move_to_index
    redirect_to root_path unless current_user.id == @board.user_id
  end
end

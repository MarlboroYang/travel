class BoardsController < ApplicationController
  before_action :find_board, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def index
    @boards = Board.all
  end
  def new 
    @board = Board.new
  end
  def create
    @board = current_user.boards.new(board_params)
    if @board.save
      redirect_to boards_path, notice: "新增成功"
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @board.update(board_params)
      redirect_to boards_path, notice: "更新成功"
    else
      render :edit
    end
  end
  def destroy
    @board.destroy
    redirect_to boards_path, notice: "看版已刪除"
  end
  private
  def find_board
    @board = Board.find(params[:id])
  end
  def board_params
    params.require(:board).permit(:title)
  end
end
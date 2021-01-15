class BoardsController < ApplicationController
  before_action :find_board, only: [:edit, :update, :destroy, :hide, :open, :lock]
  before_action :authenticate_user!

  def index
    @boards = Board.all.page(params[:page]).per(5)
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

  def hide
    authorize @board, :hide?
    @board.hide! if @board.may_hide?
    redirect_to boards_path, notice: '看板去旅遊了！ '
  end

  def open
    @board.open! if @board.may_open?
    redirect_to boards_path, notice: '看板回來了！ '
  end

  def lock
    @board.lock! if @board.may_lock?
    redirect_to boards_path, notice: '看板去睡了！ '
  end

  private

  def find_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title)
  end
end
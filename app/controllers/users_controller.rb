class UsersController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @users = User.all
  end

  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice]="You have updated user successfully."
      redirect_to books_path(@book.id)
    else
      render :index
    end
  end

  def edit
    user = User.find(params[:id])

    @user = current_user
  end

  def update
   user = User.find(params[:id])

    @user = User.find(params[:id])
    @user.update(user_params)

  if @user.save
      flash[:notice]="You have updated user successfully."
      redirect_to user_path(@user.id)
  else
    @users = User.all
     render :edit
  end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end


end

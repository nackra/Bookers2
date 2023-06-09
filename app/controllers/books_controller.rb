class BooksController < ApplicationController
 before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def create

    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @user = current_user
    if @book.save
      flash[:notice]="Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end

  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_comment = BookComment.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
  if @book.save
     flash[:notice] = "Book was successfully updated."
     redirect_to book_path(@book.id)
  else
    @books = Book.all
    render :edit
  end
  end


  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private

   def book_params
    params.require(:book).permit(:title, :body)
   end

    def is_matching_login_user
     user = User.find(params[:id])
     unless user.id == current_user.id
      redirect_to books_path
     end
    end
end

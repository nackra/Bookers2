class RelationshipsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    relationships = current_user.relationships.new(book_id: book.id)
    relationships.save
    redirect_to book_path(book)
  end

  def destroy
    book = Book.find(params[:book_id])
    relationships = current_user.relationships.find_by(book_id: book.id)
    relationships.destroy
    redirect_to book_path(book)
  end

end

require 'json'

class BooksController < ApplicationController
  def initialize
    super
    @book_service = BooksService.new
  end

  def index
    filters = params.permit(:search_by_name)
    books = Book.search_by_name

    render json: {books: books}
  end

  def create
    payload = params.permit(:name, :pages, )

    begin
      render json: @book_service.create_book(payload)
    rescue Mongoid::Errors::Validations => e
      render json: {"error": e.summary} , :status => :bad_request
    end
  end

  def show
    bookId = params[:id]

    begin
      book = @book_service.get_book(bookId)

      if(!book)
        render json: {"error": "Book with id:#{bookId} not found.", book: nil}, :status => :not_found
      end

    rescue Exception => e
        render :status => :internal_server_error
    end
  end

  def update
      payload = params.require(:book).permit(:book)

  begin
        update_result = @book_service.update_book(params[:id], payload[:book])
        puts "Update result: #{update_result.to_s}"

        if(!update_result)
          render json: {"error": "Book with id:#{params[:id]} not found.", book: nil}, :status => :not_found
        end

      rescue Mongoid::Errors::Validations => e
        render json: {"error": e.summary}, :status => :bad_request
      rescue Exception => e
        render json:{error: e.to_json}, :status => :internal_server_error
    end
  end
end

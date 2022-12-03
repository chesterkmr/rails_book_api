class BooksService
  def get_books(filters)
    q = filters["search_by_name"]

    Book.search_by_name
  end

  def get_book(bookId)
    begin
      Book.find(bookId)
    rescue Mongoid::Errors::DocumentNotFound => e
      nil
    end
  end

  def create_book(payload)
    Book.create!(:name => payload[:name], :pages => payload[:pages])
  end

  def update_book(id, payload)
    book = get_book(id)

    if(book == nil)
      return nil
    end

    puts "BOOK: #{book.to_s}"

    book.update(payload)
  end
end

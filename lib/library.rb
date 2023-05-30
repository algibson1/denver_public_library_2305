class Library
  attr_reader :name,
              :books,
              :authors,
              :checked_out_books
  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
  end

  def add_author(author)
    @authors << author
    @books << author.books
    @books.flatten!
  end

  def publication_time_frame(author)
    return "Author not found" if !authors.include?(author)
    book_years = author.books.map {|book| book.publication_year}
    ordered_years = book_years.sort 
    {start: ordered_years.first, end: ordered_years.last}
  end

  def checkout(book)
    return false if !@books.include?(book) || book.checked_out?
    @checked_out_books << book
    book.checkout
  end

  def return(book)
    return "#{book.title} is not checked out" if !book.checked_out?
    @checked_out_books.delete(book)
    book.return
  end

  def most_popular_book 
    books_ordered_by_popularity = @books.sort_by {|book| book.times_checked_out}
    books_ordered_by_popularity.last
  end

  def inventory
    inventory = {}
    @authors.each do |author|
      inventory[author] = author.books
    end
    inventory
  end
end
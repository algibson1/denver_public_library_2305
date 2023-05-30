class Book
  attr_reader :title,
              :times_checked_out
  def initialize(book_details)
    @author_first_name = book_details[:author_first_name]
    @author_last_name = book_details[:author_last_name]
    @title = book_details[:title]
    @publication_date = book_details[:publication_date]
    @checked_out_status = false
    @times_checked_out = 0
  end

  def author
    "#{@author_first_name} #{@author_last_name}"
  end

  def publication_year
    @publication_date[-4..-1]
  end

  def checkout
    return false if @checked_out_status == true
    @times_checked_out += 1
    @checked_out_status = true
  end
  
  def return
    return "Not checked out" if @checked_out_status == false
    @checked_out_status = false
  end
end 
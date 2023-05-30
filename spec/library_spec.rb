require './lib/book'
require './lib/author'
require './lib/library'
require 'rspec'

describe Library do
  before do
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847") 
    @professor = @charlotte_bronte.write("The Professor", "1857")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it 'exists' do
    expect(@dpl).to be_a(Library)
  end

  it 'has a name' do
    expect(@dpl.name).to eq("Denver Public Library")
  end

  it 'has no books by default' do
    expect(@dpl.books).to eq([])
  end

  it 'has no books, so no authors' do
    expect(@dpl.authors).to eq([])
  end

  it 'can add authors, which adds their book collections' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.authors).to eq([@charlotte_bronte, @harper_lee])
    expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
  end

  it 'reports earliest and latest publication available of an author' do
    @dpl.add_author(@charlotte_bronte)
    expect(@dpl.publication_time_frame(@charlotte_bronte)).to eq({start: "1847", end: "1857"})
    expect(@dpl.publication_time_frame(@harper_lee)).to eq("Author not found")
  end

  it 'can checkout books, if available and not already checked out' do
    expect(@dpl.checkout(@jane_eyre)).to eq(false)
    @dpl.add_author(@charlotte_bronte)
    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checkout(@jane_eyre)).to eq(false)
    expect(@dpl.checkout(@professor)).to eq(true)
    expect(@dpl.checkout(@professor)).to eq(false)
  end

  it 'can report books currently checked out' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.books).to eq([@jane_eyre, @professor, @villette, @mockingbird])
    expect(@dpl.checked_out_books).to eq([])
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@professor)
    @dpl.checkout(@mockingbird)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @professor, @mockingbird])
  end

  #method: books_available 
    #not required. Do last for funsies

  it 'can return checked out books' do
    @dpl.add_author(@charlotte_bronte)
    expect(@dpl.return(@jane_eyre)).to eq("Jane Eyre is not checked out")
    @dpl.checkout(@jane_eyre)
    expect(@dpl.return(@professor)).to eq("The Professor is not checked out")
    @dpl.checkout(@professor)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @professor])
    @dpl.return(@jane_eyre)
    expect(@dpl.checked_out_books).to eq([@professor])
    @dpl.return(@professor)
    expect(@dpl.checked_out_books).to eq([])
  end

  it 'can report which book is checked out most' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    10.times do |iteration|
      @dpl.checkout(@professor)
      @dpl.return(@professor)
    end
    20.times do |iteration|
      @dpl.checkout(@mockingbird)
      @dpl.return(@mockingbird)
    end
    15.times do |iteration|
      @dpl.checkout(@jane_eyre)
      @dpl.return(@jane_eyre)
    end
    expect(@dpl.most_popular_book).to eq(@mockingbird)
  end

  it 'reports inventory' do
    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    expect(@dpl.inventory).to eq({@charlotte_bronte => [@jane_eyre, @professor, @villette], @harper_lee => [@mockingbird]})
  end
end
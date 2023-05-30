require 'rspec'
require './lib/book'

describe Book do
  before do
    @book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
  end

  it 'exists' do
    expect(@book).to be_a(Book)
  end

  it 'has a title' do
    expect(@book.title).to eq("To Kill a Mockingbird")
  end

  it 'has an author' do
    expect(@book.author).to eq("Harper Lee")
  end

  it 'has a publication year' do
    expect(@book.publication_year).to eq("1960")
  end

  it 'can be checked out, but not if already checked out' do
    expect(@book.checkout).to eq(true)
    expect(@book.checkout).to eq(false)
  end

  it 'can be returned after being checked out, and thus can be checked out again' do
    expect(@book.return).to eq("Not checked out")
    @book.checkout
    @book.return
    expect(@book.checkout).to eq(true)
  end

  it 'can count how often it is checked out' do
    expect(@book.times_checked_out).to eq(0)
    @book.checkout
    expect(@book.times_checked_out).to eq(1)
    @book.return
    expect(@book.times_checked_out).to eq(1)
    @book.checkout
    @book.checkout
    @book.checkout
    expect(@book.times_checked_out).to eq(2)
    @book.return
    @book.checkout
    @book.return
    @book.checkout
    expect(@book.times_checked_out).to eq(4)
  end
end
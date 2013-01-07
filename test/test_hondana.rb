# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/test_helper.rb'

class TestHondana < Test::Unit::TestCase
  include Hondana

  def setup
  end
  
  def test_book
    book = Book.new('4102113010')
    assert book.title.class == String
    assert book.title =~ /赤毛のアン/
  end

  def test_shelf
    shelf = Shelf.new('yuco')
    assert shelf.name.class == String
  end

  def test_2
    shelf = Shelf.new('yuco')
    isbns = shelf.books.collect { |book|
      book.isbn
    }
    assert isbns.member?('4102113010')
  end

  def test_3
    allshelves = Hondana.shelves
    allnames = allshelves.collect { |shelf|
      shelf.name
    }
    assert allnames.member?('yuco')
    assert allnames.member?('増井')
  end
end

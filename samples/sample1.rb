# -*- coding: utf-8 -*-
require 'rubygems'
require 'hondana'

# include Hondana

#book = Book.new('4167274027')
#shelf = Shelf.new('増井')
#entry = Entry.new(shelf,book)
entry = Hondana::Entry.new('増井','4167274027')
puts entry.comment
puts entry.shelf
exit

shelf = Shelf.new('yuco')
p shelf
shelf.books.each { |book|
  puts book.isbn
  puts book.title
  puts book.authors
  puts book.publisher
}

book = Book.new('4163733507')
book.shelves.each { |shelf|
  puts shelf.name
  puts shelf.url
  puts shelf.description
}






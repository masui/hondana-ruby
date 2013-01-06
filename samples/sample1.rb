# -*- coding: utf-8 -*-
require 'rubygems'
require 'hondana'

h = Hondana.new
shelfnames = h.shelfnames('4163733507')
shelfnames.each { |shelfname|
  puts shelfname
  isbns = h.isbns(shelfname)
  puts isbns.join(", ")
}
exit

shelves = h.shelves('4163733507')
shelves.each { |shelf|
  puts "#{shelf.name} #{shelf.description}"
}
exit

books = h.books('yuco')
books.each { |book|
  puts "#{book.isbn} #{book.title}"
}





# -*- coding: utf-8 -*-
require 'rubygems'
require 'hondana'
include Hondana

# ISBNが4167274027の本が登録されてる本棚をリストする

book = Book.new('4167274027')
book.shelves.each { |shelf|
  puts shelf.name
}

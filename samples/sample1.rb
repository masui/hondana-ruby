# -*- coding: utf-8 -*-
require 'rubygems'
require 'hondana'

include Hondana

# ISBNが4167274027の本の情報を得る

book = Book.new('4167274027')
puts book.title
puts book.authors
puts book.publisher


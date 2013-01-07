# -*- coding: utf-8 -*-
require 'rubygems'
require 'hondana'

include Hondana

# 「情報視覚化の本棚」の本をリストする

shelf = Shelf.new('情報視覚化')
shelf.books.each { |book|
  puts book.title
}




# -*- coding: utf-8 -*-
#
# 本棚.org API
#
require 'net/http'
require 'json'
require 'cgi'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

module Hondana
  VERSION = '0.1.1'

  def Hondana.http_get(addr)
    ret = nil
    begin
      Net::HTTP.start('api.hondana.org', 80) {|http|
        req = Net::HTTP::Get.new(addr)
        response = http.request(req)
        raise "status code error (#{response.code})" if response.code != "200"
        ret = response.body
      }
    rescue
    end
    raise "http_get failed" if ret == nil
    ret.chomp
  end

  class Book
    def initialize(isbn)
      @isbn = isbn
      @title = nil
      @authors = nil
      @publisher = nil
    end
    attr_reader :isbn

    def getdata
      data = JSON.parse(Hondana.http_get("/bookinfo?isbn=#{CGI.escape(isbn)}"))
      @title = data['title']
      @authors = data['authors']
      @publisher = data['publisher']
    end

    def title
      getdata unless @title
      @title
    end

    def authors
      getdata unless @authors
      @authors
    end

    def publisher
      getdata unless @publisher
      @publisher
    end

    def shelves
      shelfnames = JSON.parse(Hondana.http_get("/shelves?isbn=#{isbn}"))
      shelfnames.collect { |name|
        Shelf.new(name)
      }
    end
  end

  class Shelf
    def initialize(name)
      @name = name
      @url = nil
      @description = nil
    end
    attr_reader :name

    def getdata
      data = JSON.parse(Hondana.http_get("/shelfinfo?shelf=#{CGI.escape(name)}"))
      @url = data['url']
      @description = data['description']
    end

    def url
      getdata unless @url
      @url
    end

    def description
      getdata unless @description
      @description
    end

    def books
      isbns = JSON.parse(Hondana.http_get("/books?shelf=#{@name}"))
      isbns.collect { |isbn|
        Book.new(isbn)
      }
    end
  end

  class Entry
    def initialize(shelf,book)
      @shelf = shelf
      if shelf.class == String
        @shelf = Shelf.new(shelf)
      end
      @book = book
      if book.class == String
        @book = Book.new(book)
      end
      @comment = nil
      @score = nil
      @categories = nil

      data = JSON.parse(Hondana.http_get("/entry?shelf=#{@shelf.name}&isbn=#{@book.isbn}"))
      @comment = data['comment']
      @score = data['score']
      @categories = data['categories']
    end
    attr_reader :shelf
    attr_reader :book
    attr_reader :comment
    attr_reader :categories
    attr_reader :score

  end

  def Hondana.books(pattern=nil)
    isbns = 
      if pattern
        JSON.parse(Hondana.http_get("/books?pattern=#{pattern}"))
      else
        JSON.parse(Hondana.http_get("/books"))
      end
    isbns.collect { |isbn|
      Book.new(isbn)
    }
  end

  def Hondana.shelves(pattern=nil)
    shelves = 
      if pattern
        JSON.parse(Hondana.http_get("/shelves?pattern=#{pattern}"))
      else
        JSON.parse(Hondana.http_get("/shelves"))
      end
    shelves.collect { |name|
      Shelf.new(name)
    }
  end
end


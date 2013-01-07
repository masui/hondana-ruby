# -*- coding: utf-8 -*-
#
# 本棚.org API
#
require 'net/http'
require 'json'
require 'cgi'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

class Hondana
  VERSION = '0.0.1'

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
      data = JSON.parse(Hondana.http_get("/bookinfo?isbn=#{isbn}"))
      @isbn = isbn
      @title = data['title']
      @authors = data['authors']
      @publisher = data['publisher']
    end
    attr_reader :title
    attr_reader :isbn
    attr_reader :authors
    attr_reader :publisher
  end

  class Shelf
    def initialize(name)
      data = JSON.parse(Hondana.http_get("/shelfinfo?shelf=#{CGI.escape(name)}"))
      @name = name
      @url = data['url']
      @description = data['description']
    end
    attr_reader :name
    attr_reader :description
    attr_reader :url
  end

  def initialize
  end

  def Hondana.books(shelf='',pattern='')
    if shelf == '' && pattern == ''
      JSON.parse(Hondana.http_get("/books"))
    elsif pattern == ''
      JSON.parse(Hondana.http_get("/books?shelf=#{shelf}"))
    elsif shelf == ''
      JSON.parse(Hondana.http_get("/books?pattern=#{pattern}"))
    else
      JSON.parse(Hondana.http_get("/books?pattern=#{shelf},#{pattern}"))
    end
  end

  def Hondana.book(isbn)
    Book.new(isbn)
  end

  def __books(shelf='',pattern='')
    isbns(shelf,pattern).collect { |isbn|
      Book.new(isbn)
    }
  end

  def Hondana.shelves(isbn='',pattern='')
    if isbn == '' && pattern == ''
      JSON.parse(Hondana.http_get("/shelves"))
    elsif pattern == ''
      JSON.parse(Hondana.http_get("/shelves?isbn=#{isbn}"))
    elsif isbn == ''
      JSON.parse(Hondana.http_get("/shelves?pattern=#{pattern}"))
    else
      JSON.parse(Hondana.http_get("/shelves?pattern=#{isbn},#{pattern}"))
    end
  end

  def Hondana.shelf(name)
    Shelf.new(name)
  end

  def __shelves(isbn='',pattern='')
    shelfnames(isbn,pattern).collect { |name|
      Shelf.new(name)
    }
  end
end

require File.dirname(__FILE__) + '/test_helper.rb'

class TestHondana < Test::Unit::TestCase

  def setup
  end
  
  def test_books
    h = Hondana.new
    assert h.books('yuco').member?('4102113010')
    assert h.books(nil,'yuco').member?('4102113010')
  end
end

require './lib/pantry'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_new_pantry_starts_nil
    pantry = Pantry.new

    assert_equal 0, pantry.stock.count
  end

  def check_stock_for_not_added_item_is_0
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end





end

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

  def test_check_stock_for_not_added_item_is_0
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_pantry_can_be_restocked
    pantry = Pantry.new

    pantry.restock("cheese", 10)

    assert_equal 10 , pantry.stock_check("cheese")
    assert_equal ({"cheese" => 10}), pantry.stock
  end

  def test_can_add_multiple_items_to_pantry
    pantry = Pantry.new

    pantry.restock("cheese", 10)
    pantry.restock("peanuts", 40)
    pantry.restock("candy", 150)

    assert_equal 10 , pantry.stock_check("cheese")
    assert_equal 40 , pantry.stock_check("peanuts")
    assert_equal 150 , pantry.stock_check("candy")
  end

  def test_can_add_a_recipe
    pantry = Pantry.new
    recipe = Recipe.new("Cheese Pizza")

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    assert_equal ({"Cheese"=>20, "Flour"=>20}), recipe.ingredients
  end


end

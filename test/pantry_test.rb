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

  def test_pantry_starts_a_empty_hash
    pantry = Pantry.new

    assert_equal ({}), pantry.stock
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
    recipe = Recipe.new("Cheese Pizza")

    recipe.add_ingredient("Cheese", 20)
    recipe.add_ingredient("Flour", 20)

    assert_equal ({"Cheese"=>20, "Flour"=>20}), recipe.ingredients
  end

  def test_can_add_multiple_recipes
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Margarita")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2.add_ingredient("salt", 10)
    recipe_2.add_ingredient("Tequila", 100)
    recipe_2.add_ingredient("Limes", 20)

    assert_equal ({"Cheese"=>20, "Flour"=>20}), recipe_1.ingredients
    assert_equal ({"salt"=>10, "Tequila"=>100, "Limes"=>20}), recipe_2.ingredients
  end

  def test_shopping_cart_starts_empty_hash
    pantry = Pantry.new

    assert_equal ({}), pantry.shopping_list
  end

  def test_shopping_cart_starts_at_0
    pantry = Pantry.new

    assert_equal 0, pantry.shopping_list.count
  end

  def test_can_add_recipe_to_shopping_list
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    pantry.add_to_shopping_list(recipe_1)

    assert_equal ({"Cheese"=>20, "Flour"=>20}), pantry.shopping_list
  end

  def test_can_add_multiple_recipes_to_shopping_list
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Margarita")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2.add_ingredient("salt", 10)
    recipe_2.add_ingredient("Tequila", 100)
    recipe_2.add_ingredient("Limes", 20)

    pantry.add_to_shopping_list(recipe_1)
    pantry.add_to_shopping_list(recipe_2)

    assert_equal ({"Cheese"=>20, "Flour"=>20,"salt"=>10, "Tequila"=>100, "Limes"=>20}), pantry.shopping_list
  end

  def test_you_can_print_the_shopping_list
    pantry = Pantry.new
    recipe_1 = Recipe.new("Cheese Pizza")
    recipe_2 = Recipe.new("Margarita")

    recipe_1.add_ingredient("Cheese", 20)
    recipe_1.add_ingredient("Flour", 20)

    recipe_2.add_ingredient("salt", 10)
    recipe_2.add_ingredient("Tequila", 100)
    recipe_2.add_ingredient("Limes", 20)

    pantry.add_to_shopping_list(recipe_1)
    pantry.add_to_shopping_list(recipe_2)

    expected = "Cheese: 20\nFlour: 20\nsalt: 10\nTequila: 100\nLimes: 20\n"

    assert_equal expected, pantry.print_shopping_list
  end

  def test_what_cookbook_starts_as_empty_array
    pantry = Pantry.new

    assert_equal [], pantry.cookbook
  end

  def test_what_cookbook_count_starts_at_0
    pantry = Pantry.new

    assert_equal 0, pantry.cookbook.count
  end

  def test_what_can_i_make_show_correct_recipes
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
  end

  def test_how_many_can_i_make_of_certion_recipe
    skip
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 120)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ({"Pickles" => 4, "Peanuts" => 2}), pantry.how_many_can_i_make
  end

end

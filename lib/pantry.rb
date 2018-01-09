require './lib/recipe'

class Pantry

  attr_reader :stock,
              :shopping_list,
              :cookbook,
              :printed_list

  def initialize
    @stock = Hash.new(0)
    @shopping_list = Hash.new(0)
    @cookbook = []
    @printed_list = ""
  end

  def stock_check(item)
    @stock[item]
  end

  def restock(item, amount)
    @stock[item] += amount
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.each do |item, amount|
      @shopping_list[item] += amount
    end
  end

  def print_shopping_list
    @shopping_list.each do |item, amount|
      @printed_list << "#{item}: #{amount}\n"
    end
    printed_list
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    selcted_items = cookbook.select do |recipe|
     recipe.ingredients        #have to iterate through and compare if amoumt if more
                               #then i have in stock_check
                               
    end
  end


end

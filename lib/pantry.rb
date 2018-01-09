require './lib/recipe'
require 'pry'

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
    selected_items = cookbook.select do |recipe|
     recipe.ingredients.select { |ingredient, quantity| stock_check(ingredient) < quantity}.empty?
   end
   selected_items.map(&:name)
  end

  def how_many_can_i_make
    @stock.extract!(what_can_i_make.to_sym)

    #need to take the keys returned from what i can make and get values
    #then conpair to what stock i have
  end


end

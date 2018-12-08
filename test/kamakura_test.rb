require "test_helper"

class KamakuraTest < Minitest::Test
  class User
    include Kamakura

    attribute :name
    attribute :age
  end

  def test_attributes
    user = User.new(:name => "Piotr", :age => 31)
    assert_equal({ :name => "Piotr", :age => 31 }, user.attributes)
  end

  def test_attributes_with_string_keys
    user = User.new("name" => "Piotr", "age" => 31)
    assert_equal({ :name => "Piotr", :age => 31 }, user.attributes)
  end

  def test_hash_like_accessor_with_symbol_argument
    user = User.new(:name => "Piotr", :age => 31)
    assert_equal "Piotr", user[:name]
  end

  def test_hash_like_accessor_with_string_argument
    user = User.new("name" => "Piotr", "age" => 31)
    assert_equal "Piotr", user["name"]
  end

  def test_attribute_accessor
    user = User.new(:name => "Piotr", :age => 31)
    assert_equal "Piotr", user.name
    assert_equal 31, user.age
  end
end

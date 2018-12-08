require "test_helper"

class KamakuraTest < Minitest::Test
  class User
    include Kamakura

    attribute :name, String
    attribute :age, Integer
    attribute :active, Boolean
  end

  def test_attributes
    user = User.new(:name => "Piotr", :age => 31, :active => true)
    assert_equal({ :name => "Piotr", :age => 31, :active => true }, user.attributes)
  end

  def test_attributes_with_string_keys
    user = User.new("name" => "Piotr", "age" => 31, "active" => true)
    assert_equal({ :name => "Piotr", :age => 31, :active => true }, user.attributes)
  end

  def test_hash_like_accessor_with_symbol_argument
    user = User.new(:name => "Piotr", :age => 31, :active => true)
    assert_equal "Piotr", user[:name]
  end

  def test_hash_like_accessor_with_string_argument
    user = User.new("name" => "Piotr", "age" => 31, :active => true)
    assert_equal "Piotr", user["name"]
  end

  def test_attribute_accessor
    user = User.new(:name => "Piotr", :age => 31, :active => true)
    assert_equal "Piotr", user.name
    assert_equal 31, user.age
    assert_equal true, user.active
  end

  def test_type_conversion
    user = User.new(:name => "Piotr", :age => "31", :active => "true")
    assert_equal "Piotr", user.name
    assert_equal 31, user.age
    assert_equal true, user.active
  end
end

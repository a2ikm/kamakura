require "test_helper"

class KamakuraTest < Minitest::Test
  class Address
    include Kamakura

    attribute :country, :string
    attribute :state, :string
  end

  class User
    include Kamakura

    attribute :name, :string
    attribute :age, :integer
    attribute :active, :boolean
    attribute :friend_ids, [:integer]
    attribute :address, Address
    attribute :card_number, :integer, key: :cardNumber
  end

  USER_ATTRIBUTES = {
    name:       "Piotr",
    age:        31,
    active:     true,
    friend_ids: [1, 2],
  }

  def test_attributes
    user = User.new(USER_ATTRIBUTES)
    assert_equal USER_ATTRIBUTES, user.attributes
  end

  def test_attributes_with_string_keys
    sym_attributes = USER_ATTRIBUTES.inject({}) { |s, (k, v)| s[k.to_s] = v; s }

    user = User.new(sym_attributes)
    assert_equal USER_ATTRIBUTES, user.attributes
  end

  def test_hash_like_accessor_with_symbol_argument
    user = User.new(USER_ATTRIBUTES)
    assert_equal "Piotr", user[:name]
    assert_equal 31, user[:age]
    assert_equal true, user[:active]
    assert_equal [1, 2], user[:friend_ids]
  end

  def test_hash_like_accessor_with_string_argument
    user = User.new(USER_ATTRIBUTES)
    assert_equal "Piotr", user["name"]
    assert_equal 31, user["age"]
    assert_equal true, user["active"]
    assert_equal [1, 2], user["friend_ids"]
  end

  def test_attribute_accessor
    user = User.new(USER_ATTRIBUTES)
    assert_equal "Piotr", user.name
    assert_equal 31, user.age
    assert_equal true, user.active
    assert_equal [1, 2], user.friend_ids
  end

  def test_type_conversion
    user = User.new(USER_ATTRIBUTES)
    assert_equal "Piotr", user.name
    assert_equal 31, user.age
    assert_equal true, user.active
    assert_equal [1, 2], user.friend_ids
  end

  def test_nested_attributes
    user = User.new(:address => { :country => "US", :state => "Alabama" })
    assert_equal "US", user.address.country
    assert_equal "Alabama", user.address.state
  end

  def test_attribute_key_in_symbol
    user = User.new(:cardNumber => "1234567890")
    assert_equal 1234567890, user.card_number
  end

  def test_attribute_key_in_string
    user = User.new("cardNumber" => "1234567890")
    assert_equal 1234567890, user.card_number
  end
end

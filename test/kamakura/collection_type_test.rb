require "test_helper"

class KamakuraCollectionTypeTest < Minitest::Test
  def test_parse_nil
    type = Kamakura::CollectionType.new(Kamakura::Integer)
    assert_equal [], type.parse(nil)
  end

  def test_parse_value_in_array
    type = Kamakura::CollectionType.new(Kamakura::Integer)
    assert_equal [1234], type.parse([1234])
    assert_equal [1234], type.parse(["1234"])
  end

  def test_parse_value_not_in_array
    type = Kamakura::CollectionType.new(Kamakura::Integer)
    assert_equal [1234], type.parse(1234)
    assert_equal [1234], type.parse("1234")
  end
end

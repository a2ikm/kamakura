require "test_helper"

class KamakuraAttributeTypeTest < Minitest::Test
  def test_string_parse
    assert_equal "abcd", Kamakura::String.parse("abcd")
    assert_nil Kamakura::String.parse(nil)
    assert_equal "1234", Kamakura::String.parse(1234)
  end

  def test_integer_parse
    assert_nil Kamakura::Integer.parse("abcd")
    assert_nil Kamakura::Integer.parse(nil)
    assert_equal 1234, Kamakura::Integer.parse("1234")
  end
end

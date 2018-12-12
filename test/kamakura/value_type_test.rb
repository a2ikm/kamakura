require "test_helper"

class KamakuraValueTypeTest < Minitest::Test
  def test_string_parse
    string = Kamakura.lookup_value_type(:string)

    assert_nil string.parse(nil)
    assert_equal "abcd", string.parse("abcd")
    assert_equal "1234", string.parse(1234)
  end

  def test_integer_parse
    integer = Kamakura.lookup_value_type(:integer)

    assert_nil integer.parse("abcd")
    assert_nil integer.parse(nil)
    assert_equal 1234, integer.parse("1234")
  end

  def test_boolean_parse
    boolean = Kamakura.lookup_value_type(:boolean)

    assert_nil boolean.parse(nil)
    assert_equal true, boolean.parse(true)
    assert_equal true, boolean.parse("true")
    assert_equal true, boolean.parse(1)
    assert_equal true, boolean.parse("1")
    assert_equal false, boolean.parse(false)
    assert_equal false, boolean.parse("false")
    assert_equal false, boolean.parse(0)
    assert_equal false, boolean.parse("0")
  end

  def test_time_parse
    time = Kamakura.lookup_value_type(:time)

    assert_nil time.parse(nil)
    assert_equal Time.at(1), time.parse(Time.at(1))
    assert_equal Time.at(1), time.parse(1)
    assert_equal Time.at(1), time.parse("1")
  end

  def test_date_parse
    date = Kamakura.lookup_value_type(:date)

    assert_nil date.parse(nil, format: :any)

    today = Date.today
    assert_equal today, date.parse(today, format: :any)

    {
      httpdate:   ["Sat, 03 Feb 2001 04:05:06 GMT"],
      iso8601:    ["2001-02-03", "20010203", "2001-W05-6"],
      jd:         [2451944],
      jisx0301:   ["H13.02.03"],
      rfc2822:    ["Sat, 3 Feb 2001 00:00:00 +0000"],
      rfc3339:    ["2001-02-03T04:05:06+07:00"],
      rfc822:     ["Sat, 3 Feb 2001 00:00:00 +0000"],
      xmlschema:  ["2001-02-03"],
    }.each do |format, values|
      values.each do |value|
        assert_equal Date.send(format, value), date.parse(value, format: format)
      end
    end

    ["2001-02-03", "20010203", "3rd Feb 2001"].each do |value|
      assert_equal Date.parse(value), date.parse(value, format: :unknown)
    end

    [
      ["2001-02-03", "%Y-%m-%d"],
      ["03-02-2001", "%d-%m-%Y"],
      ["2001-034",   "%Y-%j"],
      ["2001-W05-6", "%G-W%V-%u"],
      ["2001 04 6",  "%Y %U %w"],
      ["2001 05 6",  "%Y %W %u"],
      ["sat3feb01",  "%a%d%b%y"],
    ].each do |value, format|
      assert_equal Date.strptime(value, format), date.parse(value, format: format)
    end
  end

  def test_datetime_parse
    datetime = Kamakura.lookup_value_type(:datetime)

    assert_nil datetime.parse(nil, format: :any)

    now = DateTime.now
    assert_equal now, datetime.parse(now, format: :any)

    {
      httpdate:   ["Sat, 03 Feb 2001 04:05:06 GMT"],
      iso8601:    ["2001-02-03T04:05:06+07:00", "20010203T040506+0700", "2001-W05-6T04:05:06+07:00"],
      jd:         [2451944],
      jisx0301:   ["H13.02.03T04:05:06+07:00"],
      rfc2822:    ["Sat, 3 Feb 2001 04:05:06 +0700"],
      rfc3339:    ["2001-02-03T04:05:06+07:00"],
      rfc822:     ["Sat, 3 Feb 2001 04:05:06 +0700"],
      xmlschema:  ["2001-02-03T04:05:06+07:00"],
    }.each do |format, values|
      values.each do |value|
        assert_equal DateTime.send(format, value), datetime.parse(value, format: format)
      end
    end

    ["2001-02-03T04:05:06+07:00", "20010203T040506+0700", "3rd Feb 2001 04:05:06 PM"].each do |value|
      assert_equal DateTime.parse(value), datetime.parse(value, format: :unknown)
    end

    [
      ["2001-02-03T04:05:06+07:00", "%Y-%m-%dT%H:%M:%S%z"],
      ["03-02-2001 04:05:06 PM",    "%d-%m-%Y %I:%M:%S %p"],
      ["2001-W05-6T04:05:06+07:00", "%G-W%V-%uT%H:%M:%S%z"],
      ["2001 04 6 04 05 06 +7",     "%Y %U %w %H %M %S %z"],
      ["2001 05 6 04 05 06 +7",     "%Y %W %u %H %M %S %z"],
      ["-1",                        "%s"],
      ["-1000",                     "%Q"],
      ["sat3feb014pm+7",            "%a%d%b%y%H%p%z"],
    ].each do |value, format|
      assert_equal DateTime.strptime(value, format), datetime.parse(value, format: format)
    end
  end
end

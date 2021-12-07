defmodule Y2021.D7Test do
  use ExUnit.Case
  doctest Y2021.D7
  alias Y2021.D7

  @sample "16,1,2,0,4,2,7,1,2,14"

  test "p1 sample" do
    assert 37 = D7.p1(@sample)
  end

  test "p1" do
    assert 340_987 = D7.p1()
  end

  test "p2 sample" do
    assert 168 = D7.p2(@sample)
  end

  test "p2" do
    assert 96_987_874 = D7.p2()
  end
end

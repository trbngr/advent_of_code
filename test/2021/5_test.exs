defmodule Y2021.D5Test do
  use ExUnit.Case
  doctest Y2021.D5
  alias Y2021.D5

  @sample [
    "0,9 -> 5,9",
    "8,0 -> 0,8",
    "9,4 -> 3,4",
    "2,2 -> 2,1",
    "7,0 -> 7,4",
    "6,4 -> 2,0",
    "0,9 -> 2,9",
    "3,4 -> 1,4",
    "0,0 -> 8,8",
    "5,5 -> 8,2"
  ]

  test "p1 sample" do
    assert 5 == D5.p1(@sample)
  end

  test "p1" do
    assert 6564 == D5.p1()
  end

  test "p2 sample" do
    assert 12 == D5.p2(@sample)
  end

  test "p2" do
    assert 19172 == D5.p2()
  end
end

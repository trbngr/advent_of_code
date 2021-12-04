defmodule Y2021.D3Test do
  use ExUnit.Case
  doctest Y2021.D3
  alias Y2021.D3

  @sample [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010"
  ]

  test "p1 sample" do
    assert %{gamma: 22, epsilon: 9, power_consumption: 198} == D3.p1(@sample)
  end

  test "p1" do
    assert %{power_consumption: 3_429_254} = D3.p1()
  end

  test "p2 sample" do
    assert %{
             oxygen_generator_rating: 23,
             c02_scrubber_rating: 10,
             life_support_rating: 230
           } = D3.p2(@sample)
  end

  test "p2" do
    assert %{
             c02_scrubber_rating: 3678,
             life_support_rating: 5_410_338,
             oxygen_generator_rating: 1471
           } = D3.p2()
  end
end

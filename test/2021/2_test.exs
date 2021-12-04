defmodule Y2021.D2Test do
  use ExUnit.Case
  doctest Y2021.D2
  alias Y2021.D2

  test "p1" do
    assert 1_604_850 == D2.p1()
  end

  test "2" do
    assert 1_685_186_100 == D2.p2()
  end
end

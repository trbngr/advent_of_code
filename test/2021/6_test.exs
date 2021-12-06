defmodule Y2021.D6Test do
  use ExUnit.Case
  doctest Y2021.D6
  alias Y2021.D6

  @sample "3,4,3,1,2"

  test "p1 sample" do
    assert 6 = D6.p1(@sample, 2)
    assert 26 = D6.p1(@sample, 18)
    assert 5934 = D6.p1(@sample, 80)
  end

  test "p1" do
    assert 351_092 = D6.p1(80)
  end

  test "p2 sample" do
    assert 26_984_457_539 = D6.p2(@sample)
  end

  test "p2" do
    assert 1_595_330_616_005 = D6.p2()
  end
end

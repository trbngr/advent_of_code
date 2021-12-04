defmodule Y2021.D1Test do
  use ExUnit.Case
  doctest Y2021.D1
  alias Y2021.D1

  test "p1" do
    assert 1154 == D1.p1()
  end

  test "p2" do
    assert 1127 == D1.p2()
  end
end

defmodule Y2021.D2 do
  use AOC, day: 2, year: 2021

  defp input do
    input_stream()
    |> Stream.map(&String.split/1)
    |> Stream.map(fn [instruction, x] -> {instruction, String.to_integer(x)} end)
    |> Enum.to_list()
  end

  def p1 do
    {d, h} =
      input()
      |> Enum.reduce({0, 0}, fn
        {"forward", x}, {d, h} -> {d, h + x}
        {"down", x}, {d, h} -> {d + x, h}
        {"up", x}, {d, h} -> {d - x, h}
      end)

    d * h
  end

  def p2 do
    {x, y, _aim} =
      input()
      |> Enum.reduce({0, 0, 0}, fn
        {"forward", x}, {d, h, aim} -> {d + aim * x, h + x, aim}
        {"down", x}, {d, h, aim} -> {d, h, aim + x}
        {"up", x}, {d, h, aim} -> {d, h, aim - x}
      end)

    x * y
  end
end

defmodule Y2021.D1 do
  use AOC, day: 1, year: 2021

  defp input do
    Enum.map(input_stream(), &String.to_integer/1)
  end

  def p1 do
    count_increases(input())
  end

  def p2 do
    input()
    |> Enum.chunk_every(3, 1)
    |> Enum.map(&Enum.sum/1)
    |> count_increases()
  end

  defp count_increases(values) do
    {_, count} =
      Enum.reduce(values, {nil, 0}, fn
        num, {prev, count} when num > prev -> {num, count + 1}
        num, {_prev, count} -> {num, count}
      end)

    count
  end
end

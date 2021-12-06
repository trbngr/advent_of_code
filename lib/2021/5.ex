defmodule Y2021.D5 do
  use AOC, day: 5, year: 2021

  def p1 do
    p1(input_stream() |> Enum.to_list())
  end

  def p1(input) do
    run_input(input)
  end

  def p2 do
    p2(input_stream() |> Enum.to_list())
  end

  def p2(input) do
    run_input(input, :inc_diagonals)
  end

  defp run_input(input, opt \\ nil) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, &mark_line(&1, &2, opt))
    |> Enum.count(&(elem(&1, 1) > 1))
  end

  defp mark_line([{x1, y}, {x2, y}], grid, _opt) do
    Enum.reduce(x1..x2, grid, &mark_point({&1, y}, &2))
  end

  defp mark_line([{x, y1}, {x, y2}], grid, _opt) do
    Enum.reduce(y1..y2, grid, &mark_point({x, &1}, &2))
  end

  defp mark_line([{x1, y1}, {x2, y2}], grid, :inc_diagonals) do
    [Enum.map(x1..x2, & &1), Enum.map(y1..y2, & &1)]
    |> Enum.zip()
    |> Enum.reduce(grid, &mark_point/2)
  end

  defp mark_line(_points, grid, _opt), do: grid

  defp mark_point(point, grid), do: Map.update(grid, point, 1, &(&1 + 1))

  defp parse_line(line) do
    %{"x1" => x1, "x2" => x2, "y1" => y1, "y2" => y2} =
      Regex.named_captures(~r/(?<x1>\d+),(?<y1>\d+) -> (?<x2>\d+),(?<y2>\d+)/, line)

    [
      {String.to_integer(x1), String.to_integer(y1)},
      {String.to_integer(x2), String.to_integer(y2)}
    ]
  end
end

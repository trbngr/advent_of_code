defmodule Y2021.D6 do
  use AOC, day: 6, year: 2021

  def p1(run_for_days), do: p1(input_string(), run_for_days)
  def p1(input, run_for_days), do: run(input, run_for_days)

  def p2, do: p2(input_string())
  def p2(input), do: run(input, 256)

  defp run(input, days) do
    input
    |> parse_input()
    |> Enum.frequencies()
    |> simulate(days)
    |> Map.values()
    |> Enum.sum()
  end

  defp simulate(fish, 1), do: next_day(fish)

  defp simulate(fish, day) do
    fish
    |> next_day()
    |> simulate(day - 1)
  end

  defp next_day(fish) do
    {spawn_count, fish} = Map.pop(fish, 0, 0)

    fish
    |> Enum.into(%{}, fn {days_to_spawn, count} -> {days_to_spawn - 1, count} end)
    |> Map.put(8, spawn_count)
    |> Map.update(6, spawn_count, &(&1 + spawn_count))
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end

defmodule Y2021.D6 do
  use AOC, day: 6, year: 2021

  def p1(run_for_days), do: p1(input_string(), run_for_days)

  def p1(input, run_for_days) do
    input
    |> parse_input()
    |> Enum.frequencies()
    |> live_day(run_for_days)
  end

  defp live_day(fish, 1) do
    fish
    |> evolve()
    |> Map.values()
    |> Enum.sum()
  end

  defp live_day(fish, day) do
    fish
    |> evolve()
    |> live_day(day - 1)
  end

  defp evolve(fish) do
    {fish_to_create, fish} = Map.pop(fish, 0, 0)

    fish
    |> Enum.into(%{}, fn {days_until_reset, count} -> {days_until_reset - 1, count} end)
    |> Map.put(8, fish_to_create)
    |> Map.update(6, fish_to_create, &(&1 + fish_to_create))
  end

  def p2, do: p2(input_string())

  def p2(input) do
    input
    |> parse_input()
    |> Enum.frequencies()
    |> live_day(256)
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end

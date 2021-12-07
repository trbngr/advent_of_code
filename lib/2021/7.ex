defmodule Y2021.D7 do
  use AOC, day: 7, year: 2021

  defp crab_positions(input) do
    positions =
      input
      |> String.trim()
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    {positions, Enum.max(positions)}
  end

  def p1, do: p1(input_string())

  def p1(input) do
    {crab_positions, max} = crab_positions(input)

    0..max
    |> Enum.map(&calculate_fuel_cost(&1, crab_positions))
    |> Enum.sort()
    |> hd()
  end

  defp calculate_fuel_cost(current_position, positions) do
    Enum.reduce(positions, 0, &(abs(current_position - &1) + &2))
  end

  def p2, do: p2(input_string())

  def p2(input) do
    {crab_positions, max} = crab_positions(input)

    0..max
    |> Enum.map(&calculate_real_fuel_cost(&1, crab_positions))
    |> Enum.sort()
    |> hd()
    |> floor()
  end

  defp calculate_real_fuel_cost(current_position, positions) do
    Enum.reduce(positions, 0, fn pos, acc ->
      distance = abs(current_position - pos)
      cost = (distance + 1) / 2 * distance
      acc + cost
    end)
  end
end

defmodule Y2021.D3 do
  use AOC, day: 3, year: 2021

  def p1, do: p1(input_stream())

  def p1(input) do
    %{gamma: gamma, epsilon: epsilon} = gamma_epsilon(input)
    %{gamma: gamma, epsilon: epsilon, power_consumption: gamma * epsilon}
  end

  defp gamma_epsilon(input) do
    lists =
      input
      |> Enum.map(&String.graphemes/1)
      |> Util.transpose()

    length = lists |> hd() |> length()

    gamma = Enum.map(lists, &most_significant_bit(&1, length))

    epsilon =
      Enum.map(gamma, fn
        "1" -> "0"
        "0" -> "1"
      end)

    %{gamma: Util.bin_to_int(gamma), epsilon: Util.bin_to_int(epsilon)}
  end

  defp most_significant_bit(bits, length) do
    case Enum.count(bits, &(&1 == "1")) do
      ones when ones > length / 2 -> "1"
      _ -> "0"
    end
  end

  def p2, do: p2(input_stream())

  def p2(input) do
    input = Enum.map(input, &String.graphemes/1)

    oxygen_generator_rating = oxygen_generator_rating(input)
    c02_scrubber_rating = c02_scrubber_rating(input)

    %{
      oxygen_generator_rating: oxygen_generator_rating,
      c02_scrubber_rating: c02_scrubber_rating,
      life_support_rating: oxygen_generator_rating * c02_scrubber_rating
    }
  end

  defp oxygen_generator_rating([head | _] = input) do
    [oxygen_generator_rating] =
      Enum.reduce(0..Enum.count(head), input, &oxygen_generator_rating(&1, &2))

    oxygen_generator_rating
    |> Enum.join()
    |> Util.bin_to_int()
  end

  defp oxygen_generator_rating(_position, [rating_value]) do
    [rating_value]
  end

  defp oxygen_generator_rating(position, input) do
    most_common_bit =
      input
      |> bit_distribution(position)
      |> most_common_bit()

    input
    |> Enum.map(&List.to_tuple/1)
    |> Enum.filter(&(elem(&1, position) == most_common_bit))
    |> Enum.map(&Tuple.to_list/1)
  end

  defp c02_scrubber_rating([head | _] = input) do
    [c02_scrubber_rating] = Enum.reduce(0..Enum.count(head), input, &c02_scrubber_rating(&1, &2))

    c02_scrubber_rating
    |> Enum.join()
    |> Util.bin_to_int()
  end

  defp c02_scrubber_rating(_position, [rating_value]) do
    [rating_value]
  end

  defp c02_scrubber_rating(position, input) do
    least_common_bit =
      input
      |> bit_distribution(position)
      |> least_common_bit()

    input
    |> Enum.map(&List.to_tuple/1)
    |> Enum.filter(&(elem(&1, position) == least_common_bit))
    |> Enum.map(&Tuple.to_list/1)
  end

  defp least_common_bit(bits) do
    case bits do
      %{"0" => n, "1" => n} -> "0"
      %{"0" => z, "1" => o} when o > z -> "0"
      %{"0" => z, "1" => o} when z > o -> "1"
    end
  end

  defp most_common_bit(bits) do
    case bits do
      %{"0" => n, "1" => n} -> "1"
      %{"0" => z, "1" => o} when o > z -> "1"
      %{"0" => z, "1" => o} when z > o -> "0"
    end
  end

  def bit_distribution(input, position) do
    input
    |> Stream.zip_with(& &1)
    |> Stream.map(fn position_bits ->
      Enum.reduce(position_bits, %{"0" => 0, "1" => 0}, fn bit, acc ->
        Map.update!(acc, bit, &(&1 + 1))
      end)
    end)
    |> Stream.with_index()
    |> Enum.find(&match?({_bits, ^position}, &1))
    |> elem(0)
  end
end

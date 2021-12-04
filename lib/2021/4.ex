defmodule Y2021.D4 do
  ##############################
  # Bingo BingoBoard
  ##############################
  defmodule BingoBoard do
    defstruct state: :in_progress, rows: [], score: 0

    def new(["" | rows]), do: %__MODULE__{rows: Enum.map(rows, &new_row/1)}

    defp new_row(row) do
      row
      |> String.split()
      |> Enum.map(&String.to_integer/1)
    end

    @spec accept_number(struct(), integer()) :: struct()
    def accept_number(%__MODULE__{rows: rows} = board, number) do
      %{board | rows: Enum.map(rows, &mark_number(&1, number))}
      |> update_state()
      |> update_score(number)
    end

    defp mark_number(row, number) do
      Enum.map(row, fn
        ^number -> {number}
        number -> number
      end)
    end

    defp update_score(%{rows: rows} = board, number) do
      unmarked_sum =
        Enum.reduce(rows, 0, fn row, acc ->
          row
          |> Enum.reject(&is_tuple/1)
          |> Enum.sum()
          |> Kernel.+(acc)
        end)

      %{board | score: unmarked_sum * number}
    end

    defp update_state(board) do
      case has_winning_row?(board) || has_winning_column?(board) do
        false -> board
        true -> %{board | state: :winner}
      end
    end

    defp has_winning_row?(%{rows: rows}), do: Enum.any?(rows, &is_winning_row/1)

    defp has_winning_column?(%{rows: rows}) do
      rows
      |> Enum.zip_with(& &1)
      |> Enum.any?(&is_winning_row/1)
    end

    defp is_winning_row(row), do: Enum.all?(row, &is_tuple/1)
  end

  ##############################
  # Day 4
  ##############################
  use AOC, day: 4, year: 2021

  defp parse_input([moves | boards]) do
    %{
      moves: String.split(moves, ",") |> Enum.map(&String.to_integer/1),
      boards: boards |> Enum.chunk_every(6) |> Enum.map(&BingoBoard.new/1)
    }
  end

  ##############################
  # Part 1
  ##############################
  def p1 do
    p1(input_stream() |> Enum.to_list())
  end

  def p1(input) do
    %{moves: moves, boards: boards} = parse_input(input)

    Enum.reduce_while(moves, boards, fn number, acc ->
      boards = Enum.map(acc, &BingoBoard.accept_number(&1, number))

      case Enum.find(boards, &match?(%{state: :winner}, &1)) do
        nil -> {:cont, boards}
        board -> {:halt, board}
      end
    end)
  end

  ##############################
  # Part 2
  ##############################
  def p2 do
    p2(input_stream() |> Enum.to_list())
  end

  def p2(input) do
    %{moves: moves, boards: boards} = parse_input(input)

    Enum.reduce_while(moves, boards, fn number, acc ->
      boards = Enum.map(acc, &BingoBoard.accept_number(&1, number))

      case boards do
        boards when length(boards) > 1 ->
          {:cont, Enum.reject(boards, &match?(%{state: :winner}, &1))}

        [%{state: :winner} = board] ->
          {:halt, board}
      end
    end)
  end
end

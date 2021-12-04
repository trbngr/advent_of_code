defmodule Util do
  def bin_to_int(bin) when is_list(bin) do
    bin
    |> Enum.join()
    |> bin_to_int()
  end

  def bin_to_int(bin) do
    :erlang.binary_to_integer(bin, 2)
  end

  def transpose(list) when is_list(list) do
    list
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end
end

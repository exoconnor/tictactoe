defmodule TicTacToe.Board do

  def new, do: Enum.chunk_every(1..9, 3)

  def at(board, position) do
    board
    |> List.flatten
    |> Enum.at(position - 1)
  end

  def put(board, token, position) when position <= 9 and position >= 1 do
    if is_number(at(board, position)) do
      updated = board
      |> List.flatten
      |> List.replace_at(position - 1, token)
      |> Enum.chunk_every(3)
      {:ok, updated}
    else
      {:error, "Illegal Move"}
    end
  end
  def put(_, _, _), do: {:error, "Illegal Move"}


  def winner?(board, token) do
    [rows(board), columns(board), diagonals(board)]
    |> List.flatten
    |> Enum.any?(fn line -> win?(token, line) end)
  end

  defp columns(board), do: Enum.zip(board)

  defp rows(board), do: Enum.map(board, &List.to_tuple/1)

  defp diagonals(board) do
    board
    |> Enum.with_index
    |> Enum.map(fn {row, idx} -> 
      Enum.at(row, idx)
    end)
    |> List.to_tuple
  end

  # Zip returns list of tuples
  defp win?(a, {a, a, a}), do: true
  defp win?(_, _), do: false
end

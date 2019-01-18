defmodule TicTacToe.Game do
  use Agent

  defstruct(
    board: TicTacToe.Board.new(),
    player: "X"
  )

  # Agent should be TicTacToe.Game
  def start_link(_) do
    Agent.start_link(fn -> %TicTacToe.Game{} end, name: __MODULE__)
  end

  def board do
    Agent.get(__MODULE__, fn state -> state.board end)
  end

  def player do
    Agent.get(__MODULE__, fn state -> state.player end)
  end

  def move(position) do
    with {:ok, state, player} <- place_token(position) do
      if not TicTacToe.Board.winner?(state.board, player) do
        {:continue, state}
      else
        {:finish, player <> " wins!"}
      end
    else
      error -> error
    end
  end

  def place_token(position) do
    Agent.get_and_update(__MODULE__, fn state ->
      with {:ok, board} <- TicTacToe.Board.put(state.board, state.player, position) do
        new_state = %TicTacToe.Game{board: board, player: next_player(state.player)}
        {{:ok, new_state, state.player}, new_state}
      else
        error -> {error, state}
      end
    end)
  end

  def next_player("X"), do: "O"
  def next_player("O"), do: "X"
end

defimpl Inspect, for: TicTacToe.Game do
  def inspect(game, opts) do
    board = game.board
    |> Enum.map(&format_row/1)
    |> Enum.join("\n")

    board <> "\n" <> game.player <> " to play"
  end

  def format_row(row) do
    [x1, x2, x3] = Enum.map(row, &format_cell/1)
    Enum.join([x1, "|", x2, "|", x3])
  end

  def format_cell(x) when is_number(x), do: to_string(x)
  def format_cell(x), do: x
end

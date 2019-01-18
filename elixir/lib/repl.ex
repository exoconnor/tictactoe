defmodule TicTacToe.Repl do

  def start do
    IO.puts("Play a game of tic tac toe\n")
    IO.inspect(%TicTacToe.Game{})
    repl()
  end

  def repl do
    case do_command() do
      :exit -> System.stop()
      _ -> repl()
    end
  end

  def read_command do
    IO.gets("> ")
    |> String.trim
    |> String.downcase
    |> String.split(" ", [trim: true])
  end

  # Trim, split, parse?
  def do_command do
    read_command |> evaluate()
  end

  def evaluate([move | opts]) when move >= "1" and move <= "9" do
    result = move
    |> String.to_integer
    |> TicTacToe.Game.move

    case result do
      {:continue, game} -> IO.inspect(game)
      {:error, reason} -> IO.puts(reason)
      {:finish, message} ->
        IO.puts(message)
        :exit
      end
  end

  def evaluate(["opts" | opts]) do
    Enum.each(opts, &IO.inspect/1)
  end

  def evaluate(["quit" | opts]), do: :exit

  def evaluate(_) do
    IO.puts("Unknown command\n")
  end
end

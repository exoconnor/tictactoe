defmodule TicTacToe do
  use Application
  @moduledoc """
  Documentation for TicTacToe.
  """

  # Do boot logic
  def start(_type, _args) do
    children = [
      {TicTacToe.Game, []}
    ]
    Supervisor.start_link(children, [strategy: :one_for_one])
    TicTacToe.Repl.start
  end


end

# Two ways to do things
# spawn a process to hold state, send that process messages from
# the repl to change it's state

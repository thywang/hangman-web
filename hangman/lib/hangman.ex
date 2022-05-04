defmodule Hangman do
  @type state :: :initialiting | :won | :lost | :good_guess | :bad_guess | :already_used
  @type game :: any
  @type tally :: %{
    turns_left: integer,
    game_state: state,
    letters: list(String.t),
    used: list(String.t),
  }

  @spec new_game() :: game
  def new_game do
  end

  @spec make_move(game, String.t) :: { game, tally }
  # make_move will return a new game state and the tally
  def make_move(_game, _guess) do
  end
end

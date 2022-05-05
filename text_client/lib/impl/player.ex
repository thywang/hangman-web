defmodule TextClient.Impl.Player do

  @typep game :: Hangman.game
  @typep tally :: Hangman.tally
  @typep state :: { game, tally }

  @spec start() :: :ok
  def start() do
    game = Hangman.new_game()
    tally = Hangman.tally(game)
    interact({ game, tally })
  end

  # @type state :: :initializing | :won | :lost | :good_guess | :bad_guess | :already_used

  @spec interact(state) :: :ok

  def interact({_game, _tally = %{ game_state: :won }}) do
    IO.puts "Congratulations. You won!"
  end

  def interact({_game, tally = %{ game_state: :lost }}) do
    IO.puts "Sorry, you lost... the word was #{tally.letters |> Enum.join}"
    # add a try again?
  end

  def interact({ game, tally }) do
    IO.puts feedback_for(tally)
    # display current word
    # get next guess
    # make move
    # repeat
    # interact()
  end

  def feedback_for(tally = %{ game_state: :initalizing }) do
    "Welcome! I'm thinking of a #{tally.letters |> length}-letter word"
  end

  def feedback_for(_tally = %{ game_state: :good_guess }),   do: "Good guess!"
  # add random comments?
  def feedback_for(_tally = %{ game_state: :bad_guess }),    do: "Sorry, that letter's not in the word"
  def feedback_for(_tally = %{ game_state: :already_used }), do: "Sorry, that letter is already used"

end

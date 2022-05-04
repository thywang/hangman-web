defmodule HangmanImplGameTest do
  use ExUnit.Case
  alias Hangman.Impl.Game

  test "new game returns structure" do
    game = Game.new_game
    assert game.turns_left == 7
    assert game.game_state == :initalizing
    assert length(game.letters) > 0
  end

  test "new game returns correct word" do
    game = Game.new_game("kaleidoscope")
    assert game.turns_left == 7
    assert game.game_state == :initalizing
    assert game.letters == ["k", "a", "l", "e", "i", "d", "o", "s", "c", "o", "p", "e"]
  end

  test "new game returns word in lowercase letters" do
    game = Game.new_game
    assert game.turns_left == 7
    assert game.game_state == :initalizing
    assert game.letters == Enum.map(game.letters, fn x -> String.downcase(x) end)
  end

  test "state doesn't change if a game is won or lost" do
    for state <- [:won, :lost] do
      game = Game.new_game("wombat")
      game = Map.put(game, :game_state, state)
      { new_game, _tally } = Game.make_move(game, "x")
      assert new_game == game
    end
  end

  test "a duplicate letter is reported" do
      game = Game.new_game()
      { game, _tally } = Game.make_move(game, "x")
      assert game.game_state != :already_used
      { game, _tally } = Game.make_move(game, "y")
      assert game.game_state != :already_used
      { game, _tally } = Game.make_move(game, "x")
      assert game.game_state == :already_used
  end

  test "we record letters used" do
    game = Game.new_game()
    { game, _tally } = Game.make_move(game, "x")
    { game, _tally } = Game.make_move(game, "y")
    { game, _tally } = Game.make_move(game, "x")
    assert MapSet.equal?(game.used, MapSet.new(["x", "y"]))
  end

  test "we recognize a letter in the word" do
    game = Game.new_game("wombat")
    { _game, tally } = Game.make_move(game, "m")
    assert tally.game_state == :good_guess
    { _game, tally } = Game.make_move(game, "t")
    assert tally.game_state == :good_guess
  end

  test "we recognize a letter not in the word" do
    game = Game.new_game("wombat")
    { _game, tally } = Game.make_move(game, "x")
    assert tally.game_state == :bad_guess

    { _game, tally } = Game.make_move(game, "t")
    assert tally.game_state == :good_guess

    { _game, tally } = Game.make_move(game, "y")
    assert tally.game_state == :bad_guess
  end

# molly
  test "can handle a sequence of moves" do
    [
      # guess | state    turns    letters                    used
      [ "a",  :bad_guess,  6,   [ "_", "_", "_", "_", "_"], [ "a" ]],
      [ "a",  :already_used,  6,   [ "_", "_", "_", "_", "_"], [ "a" ]],
      [ "o",  :good_guess, 6,   [ "_", "o", "_", "_", "_"], [ "a", "o" ]],
      [ "x",  :bad_guess,  5,   [ "_", "o", "_", "_", "_"], [ "a", "o", "x" ]],

    ]
    |> test_sequence_of_moves()
  end

  def test_sequence_of_moves(script) do
    game = Game.new_game("molly")
    Enum.reduce(script, game, &check_one_move/2)
  end

  defp check_one_move([ guess, state, turns, letters, used ], game) do
    { game, tally } = Game.make_move(game, guess)

    assert tally.game_state == state
    assert tally.turns_left == turns
    assert tally.letters    == letters
    assert tally.used       == used

    game
  end

end

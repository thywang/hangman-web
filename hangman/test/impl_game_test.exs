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

end

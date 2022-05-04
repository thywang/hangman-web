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
end

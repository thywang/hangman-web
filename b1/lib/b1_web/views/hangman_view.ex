defmodule B1Web.HangmanView do
  use B1Web, :view

  @status_fields %{
    initializing: { "initializing", "Guess the word, a letter at a time" },
    good_guess:   { "good-guess",   "Good guess!" },
    bad_guess:    { "bad-guess",    "Sorry, that's a bad guess" },
    won:          { "won",          "Congratulations, you won!" },
    lost:         { "lost",         "Sorry, you lost" },
    already_used: { "already-used", "You already used that letter" }
  }

  def move_status(status) do
    { class, msg } = @status_fields[status]
    "<div class='status #{class}'>#{msg}</div>" |> raw()
  end

  def figure_for(0) do
    ~s{
        _______
      |      \\|
      O       |
     /|\\      |
     / \\      |
              |
              |
           ___|_
    }
  end

  def figure_for(1) do
    ~s{
        _______
      |      \\|
      O       |
     /|\\      |
     /        |
              |
              |
           ___|_
    }
  end

  def figure_for(2) do
    ~s{
        _______
      |      \\|
      O       |
     /|\\      |
              |
              |
              |
           ___|_
    }
  end

  def figure_for(3) do
    ~s{
        _______
      |      \\|
      O       |
     /|       |
              |
              |
              |
           ___|_
    }
  end

  def figure_for(4) do
    ~s{
        _______
      |      \\|
      O       |
      |       |
              |
              |
              |
           ___|_
    }
  end

  def figure_for(5) do
    ~s{
        _______
      |      \\|
      O       |
              |
              |
              |
              |
           ___|_
    }
  end

  def figure_for(6) do
    ~s{
        _______
      |      \\|
              |
              |
              |
              |
              |
           ___|_
    }
  end

  def figure_for(7) do
    ~s{
        _______
             \\|
              |
              |
              |
              |
              |
           ___|_
    }
  end


end

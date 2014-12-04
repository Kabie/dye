defmodule DyeTest do
  use ExUnit.Case
  import Dye

  test "Dyed text" do
    [
      ~d"Black text"b,
      ~D"Bright black text"b,
      ~u"Black text with underline"b,
      ~U"Bright black text with underline"b,
      ~d"Cyan text"c,
      ~D"Bright cyan text"c,
      ~u"Cyan text with underline"c,
      ~U"Bright cyan text with underline"c,
      ~d"Default text"d,
      ~D"Bright default text"d,
      ~u"Default text with underline"d,
      ~U"Bright default text with underline"d,
      ~d"Green text"g,
      ~D"Bright green text"g,
      ~u"Green text with underline"g,
      ~U"Bright green text with underline"g,
      ~d"Magenta text"m,
      ~D"Bright magenta text"m,
      ~u"Magenta text with underline"m,
      ~U"Bright magenta text with underline"m,
      ~d"Red text"r,
      ~D"Bright red text"r,
      ~u"Red text with underline"r,
      ~U"Bright red text with underline"r,
      ~d"Blue text"u,
      ~D"Bright blue text"u,
      ~u"Blue text with underline"u,
      ~U"Bright blue text with underline"u,
      ~d"White text"w,
      ~D"Bright white text"w,
      ~u"White text with underline"w,
      ~U"Bright white text with underline"w,
      ~d"Yellow text"y,
      ~D"Bright yellow text"y,
      ~u"Yellow text with underline"y,
      ~U"Bright yellow text with underline"y
    ]
    |> Enum.each(&IO.puts/1)

  end
end

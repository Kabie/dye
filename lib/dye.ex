defmodule Dye do
  import IO.ANSI

  defmacro sigil_d({:<<>>, _line, [string]}, []) do
    string
  end

  defmacro sigil_d({:<<>>, _line, [string]}, [fore]) do
    foreground(fore) <> string <> reset
  end

  defmacro sigil_d({:<<>>, _line, [string]}, [fore, back]) do
    foreground(fore) <> background(back) <> string <> reset
  end

  defmacro sigil_D({:<<>>, _line, [string]}, []) do
    string
  end

  defmacro sigil_D({:<<>>, _line, [string]}, [fore]) do
    bright <> foreground(fore) <> string <> reset
  end

  defmacro sigil_D({:<<>>, _line, [string]}, [fore, back]) do
    bright <> foreground(fore) <> background(back) <> string <> reset
  end

  defmacro sigil_u({:<<>>, _line, [string]}, []) do
    string
  end

  defmacro sigil_u({:<<>>, _line, [string]}, [fore]) do
    underline <> foreground(fore) <> string <> reset
  end

  defmacro sigil_u({:<<>>, _line, [string]}, [fore, back]) do
    underline <> foreground(fore) <> background(back) <> string <> reset
  end

  defmacro sigil_U({:<<>>, _line, [string]}, []) do
    string
  end

  defmacro sigil_U({:<<>>, _line, [string]}, [fore]) do
    underline <> bright <> foreground(fore) <> string <> reset
  end

  defmacro sigil_U({:<<>>, _line, [string]}, [fore, back]) do
    underline <> bright <> foreground(fore) <> background(back) <> string <> reset
  end

  defp foreground(chr) do
    case chr do
      ?b -> black
      ?c -> cyan
      ?d -> default_color
      ?g -> green
      ?m -> magenta
      ?r -> red
      ?u -> blue
      ?w -> white
      ?y -> yellow
    end
  end

  defp background(chr) do
    case chr do
      ?b -> black_background
      ?c -> cyan_background
      ?d -> default_background
      ?g -> green_background
      ?m -> magenta_background
      ?r -> red_background
      ?u -> blue_background
      ?w -> white_background
      ?y -> yellow_background
    end
  end

end

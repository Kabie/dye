defmodule Dye do
  @moduledoc """
  Sigils for colors.

  iex> use Dye
  nil
  iex> ~s"Red text"r
  "\e[31mRed text\e[0m"
  iex> ~s"Bright red text"R
  "\e[91mBright red text\e[0m"
  iex> ~s"Bright red text with green background"Rg
  "\e[42;91mBright red text with green background\e[0m"
  iex> ~s"Underline"u
  "\e[4mUnderline\e[0m"
  iex> ~s"Underline red text"ur
  "\e[31;4mUnderline red text\e[0m"
  iex> ~s"Underline red text with bright green background"urG
  "\e[102;31;4mUnderline red text with bright green background\e[0m"
  """

  import Kernel, except: [sigil_s: 2, sigil_S: 2]

  @forecolors %{
    ?k => "30",
    ?r => "31",
    ?g => "32",
    ?y => "33",
    ?b => "34",
    ?m => "35",
    ?c => "36",
    ?w => "37",
    ?d => "39",
    ?K => "90",
    ?R => "91",
    ?G => "92",
    ?Y => "93",
    ?B => "94",
    ?M => "95",
    ?C => "96",
    ?W => "97",
  }

  @backcolors %{
    ?k => "40",
    ?r => "41",
    ?g => "42",
    ?y => "43",
    ?b => "44",
    ?m => "45",
    ?c => "46",
    ?w => "47",
    ?d => "49",
    ?K => "100",
    ?R => "101",
    ?G => "102",
    ?Y => "103",
    ?B => "104",
    ?M => "105",
    ?C => "106",
    ?W => "107",
  }

  @colors Map.keys(@forecolors)

  @default_begining %{
    bold: nil,
    italic: nil,
    underline: nil,
    inverse: nil,
    blink: nil,
    foreground: nil,
    background: nil
  }

  @default_ending %{
    ending: "0",
    blink: nil
  }

  defmacro __using__(options) do
    if (options[:func]) do
      quote do
        import Kernel, except: [sigil_s: 2, sigil_S: 2]
        import Dye, only: []
        import Dye.FuncImpl, only: [sigil_s: 2, sigil_S: 2]
      end
    else
      quote do
        import Kernel, except: [sigil_s: 2, sigil_S: 2]
        import Dye.FuncImpl, only: []
        import Dye, only: [sigil_s: 2, sigil_S: 2]
      end
    end
  end

  defmacro sigil_s({:<<>>, line, pieces}, []) do
    {:<<>>, line, Macro.unescape_tokens(pieces)}
  end
  defmacro sigil_s({:<<>>, line, pieces}, mods) do
    {begining, ending} = parse(mods)
    {:<<>>, line, [begining | Macro.unescape_tokens(pieces) ++ [ending]]}
  end

  defmacro sigil_S(string, []), do: string
  defmacro sigil_S({:<<>>, line, pieces}, mods) do
    {begining, ending} = parse(mods)
    {:<<>>, line, [begining | pieces ++ [ending]]}
  end

  defmodule FuncImpl do
    def sigil_s(string, []), do: Macro.unescape_string(string)
    def sigil_s(pieces, mods) do
      {begining, ending} = Dye.parse(mods)
      begining <> Macro.unescape_string(pieces) <> ending
    end

    def sigil_S(string, []), do: string
    def sigil_S(string, mods) do
      {begining, ending} = Dye.parse(mods)
      begining <> string <> ending
    end
  end

  def parse(mods) do
    parse(mods, @default_begining, @default_ending)
  end

  defp parse([?e | mods], begining, ending) do
    parse(mods, begining, %{ending | ending: nil})
  end

  defp parse([?D | mods], begining, ending) do
    parse(mods, %{begining | bold: "1"}, ending)
  end

  defp parse([?i | mods], begining, ending) do
    parse(mods, %{begining | italic: "3"}, ending)
  end

  defp parse([?u | mods], begining, ending) do
    parse(mods, %{begining | underline: "4"}, ending)
  end

  defp parse([?l | mods], begining, ending) do
    parse(mods, %{begining | blink: "5"}, %{ending | blink: "25"})
  end

  defp parse([?L | mods], begining, ending) do
    parse(mods, %{begining | blink: "6"}, %{ending | blink: "25"})
  end

  defp parse([?I | mods], begining, ending) do
    parse(mods, %{begining | inverse: "7"}, ending)
  end

  defp parse([color | mods], %{foreground: nil} = begining, ending) when color in @colors do
    parse(mods, %{begining | foreground: @forecolors[color]}, ending)
  end

  defp parse([color | mods], %{background: nil} = begining, ending) when color in @colors do
    parse(mods, %{begining | background: @backcolors[color]}, ending)
  end

  defp parse([mod | mods], begining, ending) do
    parse(mods, begining, ending)
  end

  defp parse([], begining, ending) do
    {join(begining), join(ending)}
  end

  defp join(opts) do
    opts
    |> Map.values
    |> Enum.reject(&is_nil/1)
    |> Enum.join(";")
    |> (fn
      "" -> ""
      s -> "\e[#{s}m"
    end).()
  end

end

defmodule Dye do
  @moduledoc """
  Sigils for colors.
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

  defmacro __using__(_options) do
    quote do
      import Kernel, except: [sigil_s: 2, sigil_S: 2]
      import Dye
    end
  end

  def sigil_s(string, mods) do
    {begining, ending} = parse(mods, @default_begining, @default_ending)
    begining <> Macro.unescape_string(string) <> ending
  end

  def sigil_S(string, mods) do
    {begining, ending} = parse(mods, @default_begining, @default_ending)
    begining <> string <> ending
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
    IO.puts :stderr, sigil_s("Dye: unknown modifier: #{<<mod>>}", 'r')
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

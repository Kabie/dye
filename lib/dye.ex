defmodule Dye do
  @forecolors %{
    ?k => "30",
    ?r => "31",
    ?g => "32",
    ?y => "33",
    ?b => "34",
    ?m => "35",
    ?c => "36",
    ?w => "37",
    ?K => "90",
    ?R => "91",
    ?G => "92",
    ?Y => "93",
    ?B => "94",
    ?M => "95",
    ?C => "96",
    ?W => "97"
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
    ?K => "100",
    ?R => "101",
    ?G => "102",
    ?Y => "103",
    ?B => "104",
    ?M => "105",
    ?C => "106",
    ?W => "107"
  }

  def sigil_d(string, opts) do
    parse(opts) <> Macro.unescape_string(string) <> "\e[0m"
  end

  def sigil_D(string, opts) do
    parse(opts) <> string <> "\e[0m"
  end


  defp parse([]), do: ""

  defp parse(opts) do
    "\e[#{opts |> to_color_codes |> Enum.join(";")}m"
  end


  defp to_color_codes([]), do: []

  defp to_color_codes([?u | colors]) do
    ["4" | to_color_codes(colors)]
  end

  defp to_color_codes([fgc]) do
    [Map.get(@forecolors, fgc)]
  end

  defp to_color_codes([fgc, bgc | _]) do
    [Map.get(@forecolors, fgc), Map.get(@backcolors, bgc)]
  end

end

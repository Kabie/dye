defmodule DyeTest do
  use ExUnit.Case
  import Dye

  test "Dyed text" do
    colors = 'krgybmcwKRGYBMCW'

    colors
    |> Enum.map(fn
      i ->
        colors
        |> Enum.map(& [i, &1])
        |> Enum.map(&(sigil_d(to_string(&1), &1)))
    end)
    |> Enum.each(&IO.puts/1)

  end
end

defmodule Dye.Test do
  use ExUnit.Case, async: false
  use Dye

  test "Dyed text" do
    colors = 'dkrgybmcwKRGYBMCW'

    colors
    |> Enum.map(fn
      i ->
        colors
        |> Enum.map(& [i, &1])
        |> Enum.map(&(sigil_s(to_string(&1), &1)))
    end)
    |> Enum.each(&IO.puts/1)

  end
end

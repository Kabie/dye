defmodule Dye.Test do
  use ExUnit.Case, async: false
  use Dye
  doctest Dye

  test "Keep origin `~s` behavior" do
    world = "world"
    assert ~s"Hello #{world}" === "Hello world"
    assert ~S"Hello #{world}" === "Hello \#{world}"
  end

  test "Dyed text" do
    use Dye, func: true

    colors = 'dkrgybmcwKRGYBMCW'

    for fc <- colors do
      for bc <- colors do
        sigil_S(<<fc, bc>>, [fc, bc])
      end
    end
    |> Enum.each(&IO.puts/1)
  end

end

defmodule Dye.Mixfile do
  use Mix.Project

  def project do
    [app: :dye,
     version: "0.2.0",
     elixir: "~> 1.1.0-dev",
     description: "Dyeing your terminal!",
     package: package,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp package do
    [# These are the default files included in the package
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     contributors: ["Kabie"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Kabie/dye"}]
  end

  defp deps do
    []
  end
end

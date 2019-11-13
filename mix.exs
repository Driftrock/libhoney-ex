defmodule Libhoney.Mixfile do
  use Mix.Project

  def project do
    [
      app: :libhoney_ex,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      name: "libhoney_ex",
      source_url: "https://github.com/driftrock/libhoney-ex",
      description: "A client for interacting with honeycomb.io",
      package: package()
    ]
  end

  def application do
    [
      mod: { Libhoney, [] },
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 1.5"},
      {:bypass, "~> 0.8.1", only: :test},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp package do
    [
      name: "libhoney_ex",
      maintainers: ["dev@driftrock.com"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/driftrock/libhoney-ex"}
    ]
  end
end

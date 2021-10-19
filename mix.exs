defmodule MysqlexPool.Mixfile do
  @moduledoc """
  A warpper for mysqlex to add connection pooling with poolboy
  """
  use Mix.Project

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["M. Peter"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/mpneuried/mysqlex_pool"
      }
    ]
  end

  defp description do
    """
    A warpper for mysqlex to add connection pooling with poolboy
    """
  end

  def project do
    [
      app: :mysqlex_pool,
      version: "0.2.1",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description(),
      docs: [extras: ["README.md"], main: "readme"],
      test_coverage: [tool: ExCoveralls]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [:logger],
      mod: {MysqlexPool, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:poolboy, "~> 1.5"},
      {:mysqlex, "~> 0.0.2"},
      {:benchfella, "~> 0.3", only: [:dev, :test]},
      {:dialyze, "~> 0.2", only: :dev},
      {:earmark, ">= 0.0.0", only: [:docs, :dev]},
      {:ex_doc, ">= 0.0.0", only: [:docs, :dev]},
      {:excoveralls, "~> 0.8", only: [:dev, :test]}
    ]
  end
end

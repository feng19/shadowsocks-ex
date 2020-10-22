defmodule Shadowsocks.Mixfile do
  use Mix.Project

  @url "https://github.com/paulzql/shadowsocks-ex"

  def project do
    [
      app: :shadowsocks,
      version: "0.5.2",
      elixir: "~> 1.9",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "elixir port of shadowsocks",
      source_url: @url,
      homepage_url: @url,
      name: "shadowsocks",
      docs: docs(),
      package: package(),
      releases: releases()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger, :crypto], mod: {Shadowsocks.Application, []}]
  end

  defp deps do
    [{:ex_doc, "~> 0.19", only: :dev, runtime: false}, {:hkdf, "~> 0.1.0"}]
  end

  defp docs do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  defp package do
    %{
      maintainers: ["Paul Zhou"],
      licenses: ["BSD 3-Clause"],
      links: %{"Github" => @url}
    }
  end

  defp releases do
    [
      shadowsocks: [
        version: {:from_app, :shadowsocks},
        applications: [shadowsocks: :permanent],
        include_executables_for: [:unix],
        include_erts: Mix.env() != :dev,
        steps: [:assemble, :tar],
        config_providers: [{Config.Reader, {:system, "RELEASE_ROOT", "/config.exs"}}]
      ]
    ]
  end
end

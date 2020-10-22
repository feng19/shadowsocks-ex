defmodule Shadowsocks.ListenerSup do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child(args) do
    spec = {Shadowsocks.Listener, args}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end

  @impl true
  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one, extra_arguments: [])
  end
end

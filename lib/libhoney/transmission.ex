defmodule Libhoney.Transmission do
  @moduledoc false

  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def handle_cast({:send, %Libhoney.Event{} = event}, _state) do
    Task.start(fn ->
      Libhoney.Client.create_event(event)
    end)

    {:noreply, nil}
  end

  def transmit(event) do
    GenServer.cast(__MODULE__, {:send, event})
  end
end

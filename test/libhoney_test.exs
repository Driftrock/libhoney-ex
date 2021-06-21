defmodule LibhoneyTest do
  use ExUnit.Case, async: :false

  test "start" do
  end

  test "send_event" do
    refute is_nil(Process.whereis(Libhoney.Transmission))

    Application.stop(:libhoney_ex)

    Process.register(self(), Libhoney.Transmission)

    event =
      Libhoney.Event.create()
      |> Libhoney.Event.add_field("name", "baris")
      |> Libhoney.Event.add_field("score", 10)

    Libhoney.send_event(event)

    assert_received(event)

    Application.start(:libhoney_ex)
  end
end

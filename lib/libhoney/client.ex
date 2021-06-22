defmodule Libhoney.Client do
  @moduledoc false

  @content_type "application/json"

  def create_event(%Libhoney.Event{} = event) do
    url = "#{event.api_host}/1/events/#{event.dataset}"
    body = Poison.encode!(event.fields)

    headers =
      default_headers()
      |> add_header({"X-Honeycomb-Team", event.write_key})
      |> add_header({"X-Honeycomb-Samplerate", event.sample_rate})
      |> add_header({"X-Honeycomb-Event-Time", event.timestamp})

    HTTPoison.post(url, body, headers)
  end

  def create_marker(marker, dataset) do
    url = "#{Application.get_env(:libhoney_ex, :api_host)}/1/markers/#{dataset}"
    body = Poison.encode!(marker)
    headers =
      default_headers()
      |> add_header({"X-Honeycomb-Team", Application.get_env(:libhoney_ex, :write_key)})

    HTTPoison.post(url, body, headers)
  end

  defp default_headers do
    [
      {"Content-Type", @content_type},
      {"User-Agent", user_agent()}
    ]
  end

  def user_agent, do: "libhoney-ex/#{Libhoney.version}"

  defp add_header(headers, header), do: [header | headers]
end

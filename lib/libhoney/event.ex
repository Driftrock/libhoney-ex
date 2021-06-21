defmodule Libhoney.Event do
  @moduledoc """
  Provides functions for manipulating `Event` structs.
  """

  @os_module Application.get_env(:libhoney_ex, :os_mock) || :os

  @default_write_key Application.get_env(:libhoney_ex, :write_key)
  @default_dataset Application.get_env(:libhoney_ex, :dataset)
  @default_api_host Application.get_env(:libhoney_ex, :api_host) || "https://api.honeycomb.io"
  @default_api_host Application.get_env(:libhoney_ex, :api_host) || "https://api.honeycomb.io"
  @default_sample_rate Application.get_env(:libhoney_ex, :sample_rate) || 1

  @enforce_keys [:write_key, :dataset, :api_host, :sample_rate, :timestamp]
  defstruct @enforce_keys ++ [fields: %{}]

  @doc """
  Returns an `Event` struct.  All parameters are optional and will be defaulted to those set
  in the mix config.
      iex> Libhoney.Event.create(write_key: "apples", dataset: "pears", timestamp: 1512482945)
      %Libhoney.Event{api_host: "http://api.honeycomb.io", dataset: "pears",
        fields: %{}, sample_rate: 1, timestamp: 1512482945, write_key: "apples"}
  """
  def create(opts \\ []) do
    write_key = Keyword.get(opts, :write_key) || @default_write_key
    dataset = Keyword.get(opts, :dataset) || @default_dataset
    api_host = Keyword.get(opts, :api_host) || @default_api_host
    sample_rate = Keyword.get(opts, :sample_rate) || @default_sample_rate
    timestamp = Keyword.get(opts, :timestamp, @os_module.system_time(:seconds))

    %Libhoney.Event{
      write_key: write_key,
      dataset: URI.encode(dataset),
      api_host: api_host,
      sample_rate: sample_rate,
      timestamp: timestamp
    }
  end

  @doc """
  Returns an `Event` struct with a key/value pair added to the fields.
      iex> Libhoney.Event.create(write_key: "apples", dataset: "pears", timestamp: 1512482945)
      iex> evt |> Libhoney.Event.add_field("name", "Rick Anchez")
      %Libhoney.Event{api_host: "http://api.honeycomb.io", dataset: "pears",
        fields: %{"name" => "Rick Sanchez"}, sample_rate: 1, timestamp: 1512482945, write_key: "apples"}
  """
  def add_field(event, key, value) do
    new_fields =
      event.fields
      |> Map.put(to_string(key), value)

    %{ event | fields: new_fields}
  end
end

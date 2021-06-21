# libhoney_ex

A library for interacting with the [honeycomb.io](https://honeycomb.io/docs/reference/api/) API, built against the
[SDK](https://honeycomb.io/docs/reference/sdk-spec/) requirements posted by honeycomb.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `libhoney_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:libhoney_ex, "~> 0.2.0"}
  ]
end
```


## Usage

### Events

#### Constructing an event

```elixir
alias Libhoney.Event

event = Event.create(write_key: "write_key", dataset: "requests")
event =
  event
  |> Event.add_field("name", "Rick Sanchez")
  |> Event.add_field("earth_dimension", 137)
```


#### Sending an event

```elixir

alias Libhoney.Event

Event.create(write_key: "write_key", dataset: "requests")
|> Libhoney.send_event

```


### Markers

Markers are not part of the minimum spec, and haven't been added yet.

### Configuration

For now libhoney_ex allows you to configure any global settings via application config.

In your `config.exs` or `config/[env].exs`:

```elixir
config :libhoney_ex, api_host: "https://api.honeycomb.io"
config :libhoney_ex, dataset: "requests"
config :libhoney_ex, write_key: "lemons"
config :libhoney_ex, sample_rate: 1
```

Both `api_host` and `sample_rate` will use the required defaults specified by honeycomb.io, however if `dataset` or
`write_key` are not provided, attempts to contact the API will result in an error.


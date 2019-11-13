defmodule Libhoney.Sampling do
  @moduledoc false

  @enum_module Application.get_env(:libhoney, :enum_mock) || Enum

  def drop?(%{sample_rate: 1} = _event), do: false
  def drop?(%{sample_rate: sample_rate} = _event) do
    @enum_module.random(1..sample_rate) != 1
  end
end

defmodule Traffix.Light do
  @moduledoc """
  This module is the public API for the lights.
  """

  defstruct [:color]

  @typedoc """
  Struct containing light status information.
  """
  @type t :: %__MODULE__{color: atom()}

  alias Traffix.Light.Worker

  @doc """
  Reports the current color of the light.
  """
  @spec color(atom()) :: atom()
  def color(light_name) when is_atom(light_name) do
    case GenServer.whereis(light_name) do
      nil ->
        {:error,  "No light registered with name #{light_name}"}
      _pid ->
        {:ok, GenServer.call(light_name, :color)}
    end
  end

  @spec register(atom(), t()) :: :ok
  def register(light_name, %__MODULE__{} = light) when is_atom(light_name) do
    {:ok, _pid} = GenServer.start(Worker, light, name: light_name)
    :ok
  end
end

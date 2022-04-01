defmodule Traffix.Sensor do
  @moduledoc """
  This module is the public API for the traffic sensors.
  """

  defstruct car_present?: false

  @typedoc """
  Struct containing sensor status information.
  """
  @type t :: %__MODULE__{car_present?: boolean()}

  alias Traffix.Sensor.Worker

  @doc """
  Used to report that a car has arrived at a sensor.
  """
  @spec heartbeat(atom(), t()) :: :ok | {:error, String.t()}
  def heartbeat(sensor_name, %__MODULE__{} = sensor) when is_atom(sensor_name) do
    case GenServer.whereis(sensor_name) do
      nil ->
        {:ok, _pid} = GenServer.start(Worker, sensor, name: sensor_name)
        :ok
      _pid ->
        GenServer.cast(sensor_name, {:heartbeat, sensor})
    end
  end

  @doc """
  Used to ask if a sensor has a car present.
  """
  @spec car_present?(atom()) :: {:ok, boolean()} | {:error, String.t()}
  def car_present?(sensor_name) when is_atom(sensor_name) do
    case GenServer.whereis(sensor_name) do
      nil ->
        {:error, "No sensor registered with name #{sensor_name}"}
      _pid ->
        {:ok, GenServer.call(sensor_name, :car_present?)}
    end
  end
end

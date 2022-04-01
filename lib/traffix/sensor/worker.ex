defmodule Traffix.Sensor.Worker do
  @moduledoc """
  Defines the logic for holding sensor state.
  """

  use GenServer

  alias Traffix.Sensor

  @impl true
  def init(%Sensor{} = state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:car_present?, _from, %Sensor{} = state),
    do: {:reply, state.car_present?, state}

  @impl true
  def handle_cast({:heartbeat, new_state}, %Sensor{}),
    do: {:noreply, new_state}
end

defmodule Traffix.Light.Worker do
  @moduledoc """
  Defines the logic for holding light state.
  """

  use GenServer

  alias Traffix.Light

  @impl true
  def init(%Light{} = state) do
    {:ok, state}
  end

  @impl true
  def handle_call(:color, _from, %Light{} = state),
    do: {:reply, state.color, state}
end

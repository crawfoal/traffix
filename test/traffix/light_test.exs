defmodule Traffix.LightTest do
  use ExUnit.Case

  alias Traffix.Light

  describe "color/1" do
    test "it reports the current color of the light" do
      :ok = Light.register(:farm, %Light{color: :red})
      assert {:ok, :red} = Light.color(:farm)
    end
  end
end

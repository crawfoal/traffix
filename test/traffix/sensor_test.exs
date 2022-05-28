defmodule Traffix.SensorTest do
  use ExUnit.Case

  alias Traffix.Sensor

  describe "heartbeat/2" do
    test "it can properly track car presence" do
      :ok = Sensor.heartbeat(:farm_road_north, %Sensor{car_present?: true})
      assert {:ok, true} = Sensor.car_present?(:farm_road_north)

      :ok = Sensor.heartbeat(:farm_road_north, %Sensor{car_present?: false})
      assert {:ok, false} = Sensor.car_present?(:farm_road_north)
    end
  end
end

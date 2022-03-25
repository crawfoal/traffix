defmodule TraffixTest do
  use ExUnit.Case
  doctest Traffix

  test "greets the world" do
    assert Traffix.hello() == :world
  end
end

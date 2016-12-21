defmodule PhoenixHelpersTest do
  use ExUnit.Case
  doctest PhoenixHelpers

  alias PhoenixHelpers.ModelHelper

  @mixed_map %{ :key1 => "val1", "key2" => "val2" }
  @nested_map %{ key1: @mixed_map, "key2": @mixed_map }

  test "converts mixed map 1 to map with stringified keys" do
    assert ModelHelper.stringify_keys(@mixed_map) == %{ "key1" => "val1", "key2" => "val2"}
  end

  test "converts mixed map 2 to map with stringified keys" do
    assert ModelHelper.stringify_keys(@mixed_map) == %{ "key1" => "val1", "key2" => "val2"}
  end

  test "converts mixed map 1 to map with atomized keys" do
    assert ModelHelper.atomize_keys(@mixed_map) == %{ key1: "val1", key2: "val2"}
  end

  test "converts mixed map 2 to map with atomized keys" do
    assert ModelHelper.atomize_keys(@mixed_map) == %{ key1: "val1", key2: "val2"}
  end

  test "converts nested map 1 to map with stringified keys" do
    assert ModelHelper.stringify_keys(@nested_map) == %{ "key1" => %{ "key1" => "val1", "key2" => "val2"}, "key2" => %{ "key1" => "val1", "key2" => "val2"}}
  end

  test "converts nested map 1 to map with atomized keys" do
    assert ModelHelper.atomize_keys(@nested_map) == %{key1: %{key1: "val1", key2: "val2"}, key2: %{key1: "val1", key2: "val2"}}
  end


end

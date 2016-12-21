defmodule PhoenixHelpers.ModelHelper do

    @doc """
    Convert string keys of a given map to atoms
    params = %{ "foo" => "bar" }
    becomes:
             %{ :foo => "bar" }

    Mixed key format supported

    params = %{
        "key1" => foo,
        :key2 => bar
    }
    becomes:
    %{
        key1: foo,
        key2: bar
    }
    """
   def atomize_keys(params) when is_map (params)do
        params
        |> Enum.reduce(%{}, fn ({key, val}, acc) ->
            cond do
              is_map(val) -> Map.put(acc, as_atom(key), atomize_keys(val))
              is_bitstring(key) -> Map.put(acc, as_atom(key), val)
              true -> Map.put(acc,key, val)
            end
        end)
    end
    def atomize_keys(params), do: params

    @doc """
    Convert atom keys of a given map to strings
    params = %{ foo: "bar" }
    becomes:
             %{ "foo"" => "bar" }

    Mixed key format supported

    params = %{
        "key1" => foo,
        :key2 => bar
    }
    becomes:
    %{
        "key1" => foo,
        "key2" => bar
    }
    """
   def stringify_keys(params) when is_map (params)do
        params
        |> Enum.reduce(%{}, fn ({key, val}, acc) ->
            cond do
              is_map(val) -> Map.put(acc, as_string(key), stringify_keys(val))
              is_atom(key) -> Map.put(acc, as_string(key), val)
              true -> Map.put(acc,key, val)
            end
        end)
    end
    def stringify_keys(params), do: params

    def remove_nil_fields(params) when is_map(params)do
        Enum.map(params, fn({k, v}) -> filter_nil_value({k, v}) end)
        |> Enum.reject(fn(r) -> is_nil(r) end)
        |> Enum.into(%{})
    end

    def filter_nil_value({_,v}) when is_nil(v), do: nil
    def filter_nil_value({_,v}) when v == "", do: nil
    def filter_nil_value({k,v}), do: {k,v}

    def as_atom(key) when is_bitstring(key), do: String.to_atom(key)
    def as_atom(key), do: key

    def as_number(i) when is_integer(i), do: i
    def as_number(i) when is_bitstring(i), do: String.to_integer(i)
    def as_number(i), do: i

    def cast_optional_assoc(changeset, _, assoc_params) when assoc_params == nil, do: changeset
    def cast_optional_assoc(changeset, assoc, assoc_params), do: Ecto.Changeset.cast_assoc(changeset, assoc, assoc_params)

    def list_empty?([]), do: true
    def list_empty?(list) when is_list(list), do: false

    def as_string(key) when is_atom(key), do: Atom.to_string(key)
    def as_string(key), do: key

end

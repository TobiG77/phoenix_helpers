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
        |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, as_atom(key), val) end)
    end
    def atomize_keys(params), do: params

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

end

# PhoenixHelpers

A collection of functions I frequently use in my applications dealing with real world data.
 
## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `phoenix_helpers` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:phoenix_helpers, "~> 0.1.0"}]
    end
    ```

  2. Ensure `phoenix_helpers` is started before your application:

    ```elixir
    def application do
      [applications: [:phoenix_helpers]]
    end
    ```

## Usage


  1. Import in your modules
   
    ```elixir
    use PhoenixHelpers.ModelHelper
    
    
    ```
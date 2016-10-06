defmodule ModelExample.Router do
  use ModelExample.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ModelExample do
    pipe_through :api
  end
end

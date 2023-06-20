defmodule ImageConverter.Repo do
  use Ecto.Repo,
    otp_app: :image_converter,
    adapter: Ecto.Adapters.Postgres
end

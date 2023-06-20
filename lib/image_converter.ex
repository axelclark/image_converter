defmodule ImageConverter do
  @moduledoc """
  ImageConverter keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def generate_image_tags(input) do
    inputs = parse_input(input)

    inputs
    |> Enum.map(&generate_image_tag/1)
    |> Enum.filter(&String.starts_with?(&1, "<img"))
  end

  defp parse_input(input) do
    String.split(input, "\n")
  end

  defp generate_image_tag(""), do: ""

  defp generate_image_tag(markdown) do
    image_tag_start = "!["
    alt_text_end = "]("
    url_end = ")"

    [_, remaining] = String.split(markdown, image_tag_start, parts: 2)
    [alt_text, remaining] = String.split(remaining, alt_text_end, parts: 2)
    [url, _] = String.split(remaining, url_end, parts: 2)

    "<img src=\"#{url}\" alt=\"#{alt_text}\" width=\"300\">"
  end
end

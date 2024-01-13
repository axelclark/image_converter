defmodule ImageConverterWeb.ImageConverterLiveTest do
  use ImageConverterWeb.ConnCase

  import Phoenix.LiveViewTest

  test "renders the page", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")
    assert html =~ "Convert Markdown Image to HTML"

    view
    |> form("form", %{markdown_links: "![alt text](https://example.com/image.jpg)"})
    |> render_submit()

    assert has_element?(
             view,
             "p",
             "<img src=\"https://example.com/image.jpg\" alt=\"alt text\" width=\"300\">"
           )
  end
end

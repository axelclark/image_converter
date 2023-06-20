defmodule ImageConverterWeb.ImageConverterLive do
  use ImageConverterWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, image_tags: [], form: to_form(%{"markdown_links" => ""}))}
  end

  def render(assigns) do
    ~H"""
    <.header>Convert Markdown Image to HTML</.header>

    <.simple_form for={@form} phx-submit="convert">
      <.input field={@form[:markdown_links]} label="Markdown Links" type="textarea" />
      <:actions>
        <.button>Submit</.button>
      </:actions>
    </.simple_form>

    <.header class="mt-12">Results:</.header>
    <div class="mt-6 p-3 w-full border rounded-lg">
      <ul>
        <%= for image_tag <- @image_tags do %>
          <li class="text-sm text-zinc-900"><%= image_tag %></li>
        <% end %>
      </ul>
    </div>
    """
  end

  def handle_event("convert", params, socket) do
    %{"markdown_links" => markdown_links} = params
    image_tags = ImageConverter.generate_image_tags(markdown_links)
    {:noreply, assign(socket, image_tags: image_tags, form: to_form(params))}
  end
end

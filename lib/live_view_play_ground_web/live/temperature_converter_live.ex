defmodule LiveViewPlayGroundWeb.TemperatureConverterLive do
  ## See https://eugenkiss.github.io/7guis/tasks#temp
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h1>Temperature Converter</h1>
    <input phx-keyup="celsius-change" type="text" value="<%= @celsius %>" style="width: 8em">
    &nbsp℃ =&nbsp
    <input phx-keyup="farenheit-change" type="text" value="<%= @farenheit %>" style="width: 8em">
    &nbsp℉
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{celsius: nil, farenheit: nil})}
  end

  def handle_event(name, %{"value" => x}, socket)
      when name in ["celsius-change", "farenheit-change"] do
    socket =
      case Float.parse(x) do
        {x, ""} ->
          f = if name === "celsius-change", do: farenheit(x), else: x
          c = if name === "farenheit-change", do: celsius(x), else: x
          assign(socket, %{farenheit: Kernel.round(f), celsius: Kernel.round(c)})
        _ ->
          socket
      end
    {:noreply, socket}
  end

  defp celsius(f) do
    (f - 32) * (5 / 9)
  end

  defp farenheit(c) do
    c * (9 / 5) + 32
  end
end

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

  def handle_event("celsius-change", %{"value" => c}, socket) do
    socket = case Float.parse(c) do
      {c, ""} ->
        assign(socket, %{farenheit: farenheit(c), celsius: Kernel.round(c)})
      _ ->
        socket
    end
    {:noreply, socket}
  end

  def handle_event("farenheit-change", %{"value" => f}, socket) do
    socket = case Float.parse(f) do
      {f, ""} ->
        assign(socket, %{farenheit: Kernel.round(f), celsius: celsius(f)})
      _ ->
        socket
    end
    {:noreply, socket}
  end

  defp celsius(f) do
    Kernel.round((f - 32) * (5 / 9))
  end

  defp farenheit(c) do
    Kernel.round(c * (9 / 5) + 32)
  end
end

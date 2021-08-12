defmodule LiveViewPlayGroundWeb.TemperatureConverterLive do
  ## See https://eugenkiss.github.io/7guis/tasks#temp
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h1>Temperature Converter</h1>
    <p><%= @celcius %>℃/<%= @farenheit %>℉</p>
    <div">
      <input phx-keyup="celcius-change" type="text"" value="<%= @celcius %>" style="width: 8em">
      &nbspCelcius =&nbsp
      <input phx-keyup="farenheit-change" type="text"" value="<%= @farenheit %>" style="width: 8em">
      &nbspFarenheit
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{celcius: nil, farenheit: nil})}
  end

  def handle_event("celcius-change", %{"value" => c}, socket) do
    {c, _} = Float.parse(c)
    {:noreply, assign(socket, %{farenheit: farenheit(c), celcius: c})}
  end

  def handle_event("farenheit-change", %{"value" => f}, socket) do
    {f, _} = Float.parse(f)
    {:noreply, assign(socket, %{celcius: celcius(f), farenheit: f})}
  end

  defp celcius(f) do
    (f - 32) * (5 / 9)
  end

  defp farenheit(c) do
    c * (9 / 5) + 32
  end
end

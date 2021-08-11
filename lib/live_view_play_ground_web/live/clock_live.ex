defmodule LiveViewPlayGroundWeb.ClockLive do
  ## The Elm Clock (https://elm-lang.org/examples/clock) in LiveView
  use Phoenix.LiveView

  defmodule Point, do: defstruct([:x, :y])

  defmodule HandComponent do
    use Phoenix.LiveComponent

    def render(assigns) do
      ## The `width` is set just once per hand: we don't need change
      ## tracking for it but can't figure out how to do this.
      ~L"""
      <line x1="200" y1="200" x2="<%= @tip.x %>" y2="<%= @tip.y %>" stroke-width="<%= @width %>" />
      """
    end

    def update(assigns, socket) do
      {:ok, assign(socket, paint(assigns.length, assigns.width, assigns.turns))}
    end

    def paint(length, width, turns) do
      t = 2 * :math.pi() * (turns - 0.25)
      x = 200 + length * :math.cos(t)
      y = 200 + length * :math.sin(t)
      %{tip: %Point{x: x, y: y}, length: length, width: width}
    end
  end

  def render(assigns) do
    ~L"""
    <svg viewBox="0 0 400 400" width="400" height="400">
      <circle cx="200" cy="200" r="120" fill="rgb(18, 147, 216)" />
      <g stroke="white" stroke-linecap="round" >
        <%= live_component @socket, HandComponent, length: 60, width: 6, turns: (@date.hour/12.0) %>
        <%= live_component @socket, HandComponent, length: 90, width: 6, turns: (@date.minute/60.0) %>
        <%= live_component @socket, HandComponent, length: 90, width: 3, turns: (@date.second/60.0) %>
      </g>
    </svg>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    assign(socket, date: NaiveDateTime.local_now())
  end
end

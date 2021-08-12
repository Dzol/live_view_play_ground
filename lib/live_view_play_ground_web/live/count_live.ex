defmodule LiveViewPlayGroundWeb.CountLive do
  ## See https://eugenkiss.github.io/7guis/tasks#counter
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h1>Counter</h1>
    <div>
      <input type="number" value="<%= @count %>" readonly style="width: 8em">
      <input type="button" value="count" phx-click="increment">
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{count: 0})}
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end

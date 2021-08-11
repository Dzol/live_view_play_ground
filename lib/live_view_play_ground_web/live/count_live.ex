defmodule LiveViewPlayGroundWeb.CountLive do
  ## See https://eugenkiss.github.io/7guis/tasks#counter
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form>
      <h1>Counter</h1>
      <input type="number" value="<%= @count %>" readonly style="width: 8em">
      <input type="button" value="count" phx-click="increment">
    </form>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, %{count: 0})}
  end

  def handle_event("increment", _, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end
end

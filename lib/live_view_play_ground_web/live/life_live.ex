defmodule LiveViewPlayGroundWeb.LifeLive do
  ## Inspired by https://observablehq.com/@visnup/game-of-life
  use Phoenix.LiveView

  defmodule Life do
    defmodule World,
      do: @type t() :: [{integer(), integer()}]

    @spec tick(World.t()) :: World.t()
    def tick(world) do
      cell = &key/1

      world
      |> Enum.map(&neighbouring/1)
      |> List.flatten()
      |> Enum.frequencies()
      |> Enum.filter(alive?(world))
      |> Enum.map(cell)
    end

    defp alive?(world) do
      fn {cell, count} = _association ->
	(count === 3) || (count === 2 && cell in world)
      end
    end

    defp neighbouring({x, y}) do
      for dx <- [-1,0,1], dy <- [-1,0,1], not (dx === 0 and dy === 0),
	do: {x+dx, y+dy}
    end

    defp key({k, _v} = _association), do: k
  end

  def render(assigns) do
    ~L"""
    <svg viewBox="-32 -16 64 32">
      <g>
      <%= for {x, y} <- @world do %>
        <rect x="<%= x %>" y="<%= y %>" width="0.8" height="0.8" />
      <% end %>
      </g>
    </svg>
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)
    
    {:ok, put_world(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_tick(socket)}
  end

  defp put_world(socket) do
    assign(socket, world: [{0,0}, {0,1}, {0,-1}, {-1,0}, {1,1}])
  end

  defp put_tick(socket) do
    assign(socket, world: Life.tick(socket.assigns.world))
  end
end

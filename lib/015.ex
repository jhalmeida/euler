defmodule Fifteen do
  @moduledoc """
  Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.


  How many such routes are there through a 20×20 grid?
  """
  def next_step(down, right) do
    if down == right do
      2 * route(down - 1, right)
    else
      down_paths = cond do
        down > 0 -> route(down - 1, right)
        true -> 0
      end
      right_paths = cond do
        right > 0 -> route(down, right - 1)
        true -> 0
      end
      down_paths + right_paths
    end
  end

  def route(down, right) do
    case down > 0 or right > 0 do
      true ->
        next_step(down, right)
      false ->
        1
    end
  end

  # Very slow for n = 20
  def solve_tuples(n \\ 2) do
    start = DateTime.utc_now()
    paths = route(n - 1, n) * 2
    stop = DateTime.utc_now()
    IO.inspect(DateTime.diff(stop, start, :millisecond), label: "duration brute force (ms):")
    IO.inspect(paths, label: "possible routes:")
  end

# ---------------------------
  def get(node_map, x, y) do
    Map.get(node_map, List.to_string([x, y]), 0)
  end

  def put(count, node_map, x, y) do
    Map.put(node_map, List.to_string([x, y]), count)
  end

  def path_count(node_map, n, x, y) do
    IO.inspect({node_map, n, [x, y]})
    cond do
      x == 0 and y == 0 ->
        # Top corner, return full count
        2 * get(node_map, 0, 1) |> IO.inspect(label: "done")
      x == y ->
        # diagonal node, start on bottom row one step to the left
        2 * get(node_map, x, y + 1)
        |> put(node_map, x, y)
        |> path_count(n, x - 1, n)
      true ->
        # add nodes to the right and below
        right = get(node_map, x + 1, y) |> IO.inspect(label: "right")
        below = get(node_map, x, y + 1) |> IO.inspect(label: "below")
        put(right + below, node_map, x, y)
        |> path_count(n, x, y - 1)
    end
  end

  def solve(n \\ 2) do
    start = DateTime.utc_now()
    node_map = put(1, %{}, n - 1, n)
    paths = path_count(node_map, n, n - 1, n - 1)
    stop = DateTime.utc_now()
    IO.inspect(DateTime.diff(stop, start, :millisecond), label: "duration (ms):")
    IO.inspect(paths, label: "possible routes:")
  end

end

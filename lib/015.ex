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
    IO.inspect({paths, DateTime.diff(stop, start, :millisecond)}, label: "tuples2")
  end

end

defmodule Fourteen do

  def func(n, _i, _len, s, max) when n > 999999 do
    {s, max}
  end

  def func(n, i, len, s, max) when i == 1 do
    {s, max} = case len > max do
      true -> {n, len}
      false -> {s, max}
    end
    func(n + 1, n + 1, 1, s, max)
  end

  def func(n, i, len, s, max) do
    case rem(i, 2) == 0 do
      true -> func(n, div(i, 2), len + 1, s, max)
      false -> func(n, 3*i + 1, len + 1, s, max)
    end
  end

  def collatz do
    func(1,1,1,1,1) |> IO.inspect(label: "n: max:")
  end
end

defmodule Twelve do


  @factors 501


  def get_factors(n, l, len) when len > 9 do
    confirm_len =
      l
      |> List.flatten
      |> Enum.uniq
      |> length

    case confirm_len > @factors do
      true -> n * (n+1) / 2 |> Kernel.trunc()
      false ->
        IO.inspect(%{triangle: n * (n+1) / 2 |> Kernel.trunc(), n: n, hacky_len: len, confirm_len: confirm_len, factors: l}, label: "didn't meet expected length")
        get_factors(n, [], 0)
    end
  end

  def get_factors(n, _l, _len) do
    n = n + 1
    tn = n * (n + 1) / 2 |> Kernel.trunc()
    last =
      tn
      |> :math.sqrt()
      |> Kernel.trunc()

    l = for x <- 1..last, rem(tn, x) == 0, do: [x, div(tn, x)]
    get_factors(n, l, length(l) * 2)
  end

  def find_triangle_number do
    get_factors(1, [], 0)
  end
end

defmodule Twelve do

  @factors 500

  def get_factors(n, l) when l > @factors do
    n * (n+1) / 2 |> Kernel.trunc()
  end

  def get_factors(n, l) when l <= @factors do
    n = n + 1
    tn = n * (n + 1) / 2 |> Kernel.trunc()
    last =
      tn
      |> :math.sqrt()
      |> Kernel.trunc()

    l = for x <- 1..last, rem(tn, x) == 0, do: [x, div(tn, x)]
    get_factors(n, length(l) * 2)
  end

  def find_triangle_number do
    get_factors(1, 0)
  end
end

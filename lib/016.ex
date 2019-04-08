defmodule Sixteen do
  @moduledoc """
  2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

  What is the sum of the digits of the number 2^1000?
  """
  def exp(base, 1), do: base
  def exp(base, pow), do: base * exp(base, pow - 1)

  def solve(pow \\ 15) do
    exp(2, pow)
    |> Integer.to_string(10)
    |> String.graphemes()
    |> Enum.reduce(0, &(String.to_integer(&1) + &2))
  end
end
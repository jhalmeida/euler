defmodule PrimeFactor do
 
  defp is_prime(number, factor) when factor > number / 2 do true end

  defp is_prime(number, factor) do
    cond do
      rem(number, factor) == 0 ->
        IO.inspect(factor, label: "factor for non prime")
        false
      true ->
        is_prime(number, factor + 1)
    end
  end

  defp check_factor(number, factor) when factor > number / 2 do "No prime factor" end

  defp check_factor(number, factor) do
    kvot = div(number, factor)
    cond do
      rem(number, factor) == 0 ->
        IO.inspect(kvot, label: "factor found, kvot")
        IO.inspect(factor, label: "factor found, factor")
        cond do
          is_prime(kvot, 2) ->
            kvot
          true ->
            check_factor(kvot, 2)
        end
      true ->
        check_factor(number, factor + 1)
    end
  end

  def solve(number) do
    IO.inspect(number, label: "Number")
    check_factor(number, 2)
    |> IO.inspect(label: "Highest prime factor")
  end
end
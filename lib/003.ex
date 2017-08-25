defmodule PrimeFactor do
 
  defp check_factor(number, factor, highest_factor) when factor > number / 2 do
    IO.puts "=========================="
    highest_factor
  end

  defp check_factor(number, factor, highest_factor) do
    cond do
      rem(number, factor) == 0 ->
        kvot = div(number, factor)
        IO.puts "--------------------------"
        IO.inspect(kvot, label: "factor found, kvot")
        IO.inspect(factor, label: "factor found, factor")
        check_factor(kvot, 2, kvot)
      true ->
        check_factor(number, factor + 1, highest_factor)
    end
  end

  def solve(number) do
    IO.inspect(number, label: "Number")
    check_factor(number, 2, 1)
    |> IO.inspect(label: "Highest prime factor")
  end
end
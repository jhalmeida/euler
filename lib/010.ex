defmodule Ten do

  defp filter([head | tail], sum, limit) when head > limit do
    Enum.reduce([sum, head | tail], fn(x, acc) -> x + acc end)
  end
  
  defp filter([head | tail], sum, limit) do
    Enum.reject(tail, fn(x) -> rem(x, head) == 0 end)
      |> filter(sum + head, limit)
  end

  def solve do
    start_time = :os.system_time(:milli_seconds)
    limit = 10
    list = Enum.map(1..(div(limit, 2) - 1), fn x -> x * 2 + 1 end)
    filter(list, 2, :math.sqrt(limit))
      |> IO.inspect(label: "Result")
    end_time = :os.system_time(:milli_seconds)
    IO.puts("Time taken: #{(end_time - start_time)/1000}s")
  end




  defp is_prime(_num, check, root) when check > root + 1 do
    true
  end

  defp is_prime(num, check, root) do

    cond do
      rem(num, check) == 0 -> false
      true -> is_prime(num, check + 2, root)
    end
  end

  def solve_brute do
    start_time = :os.system_time(:milli_seconds)
    # num = Enum.reduce(3..2000000, 2, fn(x, acc) -> 
    #   case is_prime(x, 3, :math.sqrt(x)) do
    #     true -> acc + x
    #     _ -> acc
    #   end
    # end)

    num = 2..2000000 |> Stream.drop_every(2) |> Stream.filter(fn(x) -> is_prime(x, 3, :math.sqrt(x)) end) |> Enum.sum
    end_time = :os.system_time(:milli_seconds)
    IO.puts("Time taken: #{(end_time - start_time)/1000}s")
    IO.puts num
  end


end

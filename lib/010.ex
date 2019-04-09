defmodule Ten do

  defp filter([head | tail], sum, limit) when head > limit do
    Enum.reduce([sum, head | tail], fn(x, acc) -> x + acc end)
  end

  defp filter([head | tail], sum, limit) do
    Enum.reject(tail, fn(x) -> rem(x, head) == 0 end)
      |> filter(sum + head, limit)
  end

  def solve(limit \\ 10) do
    start_time = :os.system_time(:milli_seconds)
    list = Enum.map(1..(div(limit, 2) - 1), fn x -> x * 2 + 1 end)
    filter(list, 2, :math.sqrt(limit))
      |> IO.inspect(label: "Result")
    end_time = :os.system_time(:milli_seconds)
    IO.puts("Time taken: #{(end_time - start_time)/1000}s")
  end
end



#   defp is_prime(_num, check, root) when check > root + 1 do
#     true
#   end

#   def is_prime(num, check, root) do

#     cond do
#       rem(num, 2) == 0 -> false
#       rem(num, check) == 0 -> false
#       true -> is_prime(num, check + 2, root)
#     end
#   end

#   def async_is_prime(num, root) do
#     list = 3..round(root)
#     el = Enum.map(list, fn(x) -> Task.async(fn -> rem(num, x) == 0 end)end)
#      |> Enum.map(fn(z) ->
#       Task.await z
#      end)
#      |> Enum.member?(true)
#     case el do
#       true -> {:no_prime, num}
#       false -> {:prime, num}
#     end
#   end


#   def check_prime(num) do

#     cond do
#       is_prime(num, 3, :math.sqrt(num)) == true ->
#         num
#       true -> 0
#     end
#   end

#   def test(number) do
#     :timer.sleep 500
#     IO.puts number
#   end

#   def solve_brute do
#     start_time = :os.system_time(:milli_seconds)
#     # num = Enum.reduce(3..2000000, 2, fn(x, acc) ->
#     #   case is_prime(x, 3, :math.sqrt(x)) do
#     #     true -> acc + x
#     #     _ -> acc
#     #   end
#     # end)

#     # num = 2..2000000 |> Stream.drop_every(2) |> Stream.drop_every(3) |> Enum.reduce(2, fn(x,acc) ->
#     #   a = Task.async(fn -> is_prime(x, 3, :math.sqrt(x)) end)
#     #   case Task.await(a) do
#     #     true -> x + acc
#     #     _ -> acc
#     #   end
#     # end)
#     num = 2

#     2..20 |> Task.async_stream(fn(x) -> test(x) end) |> Enum.each(fn(el) -> IO.inspect el end)

#     2..20 |> Enum.each(fn(x) -> test(x) end)

#     # num = 2..2000000 |> Stream.drop_every(2) |> Stream.drop_every(3) |> Task.async_stream(fn(x) -> check_prime(x) end) |> Enum.reduce(2, fn(x, acc) ->
#     #   {:ok, num} = x
#     #   acc + num
#     # end)

#     # list = Enum.to_list(2..2000000)
#     # num = Task.async_stream(list, fn(x) -> check_prime(x) end)
#     # |> Enum.reduce(2, fn(x, acc) ->
#     #     {:ok, num} = x
#     #     acc + num
#     #   end)

#     # num = 2..2000000 |> Stream.drop_every(2) |> Stream.drop_every(3) |> Task.async_stream( fn(x) ->   is_prime(x, 3, :math.sqrt(x)) end)
#     # |> Enum.reduce(2, fn(aw, acc) ->
#     #   {:ok, task} = aw

#     #   case task do
#     #     {:false, num} -> acc
#     #     {:true, num} -> acc + num
#     #   end
#     # end)


#     # num = 2..20000 |> Stream.drop_every(2) |> Stream.drop_every(3) |> En Task.async_stream(fn(x) -> async_is_prime(x, :math.sqrt(x)) end)
#     #   |> Enum.reduce(2, fn(x, z) ->
#     #     {:ok, val } = x
#     #     IO.inspect val
#     #     case val do
#     #       {:prime, num} -> z + num
#     #       {:no_prime, num} -> z
#     #     end
#     #   end)
#     # |> Enum.reduce(2, fn(z, acc) ->
#     #   case z do
#     #     {:false, num} -> acc
#     #     {true, num} -> acc + num
#     #   end
#     # end)





#     end_time = :os.system_time(:milli_seconds)
#     IO.puts("Time taken: #{(end_time - start_time)/1000}s")
#     IO.inspect num
#   end


# end

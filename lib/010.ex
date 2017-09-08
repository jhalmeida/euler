defmodule Ten do

  defp filter([head | tail], sum) when head * head > 2000000 do
    Enum.reduce([sum, head | tail], fn(x, acc) -> x + acc end)
  end
  
  defp filter([head | tail], sum) do
    Enum.reject(tail, fn(x) -> rem(x, head) == 0 end)
      |> filter(sum + head)
  end

  def solve do
    start_time = :os.system_time(:milli_seconds)

    list = Enum.map(1..999999, fn x -> x * 2 + 1 end)
    list_end_time = :os.system_time(:milli_seconds)
    IO.puts("Time taken to create list: #{(list_end_time - start_time)/1000}s")
    filter(list, 2)
      |> IO.inspect(label: "Result")

    end_time = :os.system_time(:milli_seconds)
    IO.puts("Time taken: #{(end_time - start_time)/1000}s")
  end
end

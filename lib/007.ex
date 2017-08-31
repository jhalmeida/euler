defmodule Seven do
  # find 10001 prime number

  defp is_prime(num, i) when i > num / 2 do
    true
  end
  
  defp is_prime(num, i) do
    if rem(num, i) == 0 do
      false
    else
      is_prime(num, i + 2)
    end
  end

  defp prime_count(num, 10001) do
    num
  end

  defp prime_count(num, count) do
    next_num = num + 1
    if rem(next_num, 2) == 0 do
      prime_count(next_num, count)
    else
      case is_prime(next_num, 3) do
        true ->
          prime_count(next_num, count + 1)
        false ->
          prime_count(next_num, count)
      end
    end
  end

  def solve_brute do
    start_time = :os.system_time(:milli_seconds) |> IO.inspect(label: "start_time")
    num = prime_count(13, 6)
    end_time = :os.system_time(:milli_seconds) |> IO.inspect(label: "end_time")
    IO.inspect(end_time - start_time, label: "time taken")
    IO.inspect(num, label: "number")
  end

end
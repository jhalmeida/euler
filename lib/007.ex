defmodule Seven do
  # find 10001 prime number

  defp is_prime(num, i, root) when i > root do
    true
  end

  
  defp is_prime(num, i, root) do
    if rem(num, i) == 0 do
      false
    else
      case rem(i + 2, 3) do
        0 -> is_prime(num, i + 4, root)
        _ -> is_prime(num, i + 2, root)
      end
    end
  end

  defp prime_count(num, 10001) do
    num
  end

  defp prime_count(num, count) do
    next_num = num + 1
    root = :math.sqrt(next_num)
    if rem(next_num, 2) == 0 || rem(next_num, 3) == 0 do
      prime_count(next_num, count)
    else
      case is_prime(next_num, 5, root) do
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
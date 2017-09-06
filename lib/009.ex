defmodule Nine do

  def while(a, _b, _c) when a == 332 do
    false
  end

  def while(a, b, c) when b >= c do
    while(a + 1, a + 2, 1000 - (a + 1) - (a + 2))
  end
  
  def while(a, b, c) do
    IO.inspect(%{a: a, b: b, c: c}, label: "nums here")

    cond do
      a * a + b * b > c * c ->
        while(a, b + 1, 1000 - a - (b + 1))
      a * a + b * b == c * c  ->
        a * b * c 
      true -> 
        while(a, b + 1, 1000 - a - (b + 1))
    end
  end

  def solve_brute do
    start_time = :os.system_time(:milli_seconds) |> IO.inspect(label: "start_time")
    num = while(1, 2, 997)
    end_time = :os.system_time(:milli_seconds) |> IO.inspect(label: "end_time")
    IO.inspect(end_time - start_time, label: "time taken")
    IO.inspect(num, label: "number")
  end
end
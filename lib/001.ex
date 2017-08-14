defmodule One do
 
  
  def solve_brute do
    {_list, answer} =
      Enum.map_reduce(1..1000, 0,  fn(x, acc) -> 
        cond do
          rem(x,3) == 0 || rem(x, 5) == 0 ->
            { x, acc + x}
          true -> 
            {x, acc}
        end 
      end)
    answer
  end

  def solve_math(limit) do
    n = div(limit, 3)
    m = div(limit, 5)
    l = div(limit, 15)
    three_sum = div(3 * (n * (n+1)), 2)
    five_sum = div(5 * (m * (m+1)),2)
    fift_sum = div(15 * (l * (l+1)),2)
    three_sum + five_sum - fift_sum
  end



end
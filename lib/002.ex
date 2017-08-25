defmodule Two do
  
  def while(sum, cur, _prev) when cur >= 4000000 do
    sum      
  end  
  
  def while(sum, cur, prev) do
    next = prev + cur
    while(sum + next * (1 - rem(next, 2)), next, cur)
  end

  def solve_brute do
    while(0, 1, 1)
  end  

end

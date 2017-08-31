defmodule Six do
  
  def solve do
    sum_squares = Enum.reduce(1..100, 0, fn(x, acc) -> :math.pow(x,2) + acc end)
    square_sums = :math.pow(div(100 * 101, 2), 2) 
    square_sums - sum_squares
  end
end
defmodule Five do

  defp divisible(num, 10) do
    num
  end


  defp divisible(num, iterator) do
    if rem(num, iterator) == 0 do
      divisible(num, iterator - 1)
    else
      divisible(num + 20, 20)
    end
  end



  def solve do
    divisible(20*19, 20)
  end
end

defmodule SixtySeven do

  def solve do
    triangle = Eighteen.format_triangle("lib/p067_triangle.txt")
    {last, remaining} = List.pop_at(triangle, -1)
    Eighteen.calc_max(last, remaining)
  end

end

defmodule Four do

  def find_largest(99, _next, max) do
    max
  end

  def find_largest(num, 99, max) do
    find_largest(num - 1, num - 1, max)
  end

  def find_largest(num, next, max) do
    check = num * next
    cond do
      check < max -> 
        find_largest(num - 1, num - 1, max)
      to_string(check) == String.reverse(to_string(check)) -> 
        max = 
          cond do
            check > max -> 
              check
            true -> max
          end
        find_largest(num - 1, num - 1, max)
      true -> 
        find_largest(num, next - 1, max)
    end  
  end

  def solve do
    find_largest(999, 999, 0)
  end

end
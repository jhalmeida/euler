defmodule Seventeen do
  @moduledoc """
  If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

  If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?


  NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
  """


  def count_letters(s) do
    String.length(s)
  end

  def single_digit(digit) do
    numbers = %{
      0 => "",
      1 => "one",
      2 => "two",
      3 => "three",
      4 => "four",
      5 => "five",
      6 => "six",
      7 => "seven",
      8 => "eight",
      9 => "nine"
    }
    Map.get(numbers, digit)
  end

  def double_digits([d, s]) do
    numbers = %{
      10 => "ten",
      11 => "eleven",
      12 => "twelve",
      13 => "thirteen",
      14 => "fourteen",
      15 => "fifteen",
      16 => "sixteen",
      17 => "seventeen",
      18 => "eighteen",
      19 => "nineteen",
      20 => "twenty",
      30 => "thirty",
      40 => "forty",
      50 => "fifty",
      60 => "sixty",
      70 => "seventy",
      80 => "eigthy",
      90 => "ninety"
    }
    case d == 1 do
      true -> Map.get(numbers, d * 10 + s)
      false -> Map.get(numbers, d * 10) <> single_digit(s)
    end
  end

  def tripple_digits([c, d, s]) do
    hundred = single_digit(c) <> "hundred"
    hundred <> case d == 0 and s == 0 do
      true ->
        ""
      false ->
        case d > 0 do
          true -> "and" <> double_digits([d, s])
          false -> "and" <> single_digit(s)
        end
    end
  end

  def create_number(number) do
    number_list = Integer.digits(number)
    case length(number_list) do
      1 -> single_digit(number)
      2 -> double_digits(number_list)
      3 -> tripple_digits(number_list)
      4 -> "onethousand"
    end

  end

  def solve(limit \\ 1000) do

    Enum.reduce(1..limit, 0, fn (n, acc) ->
      IO.inspect([n, acc], label: "integer")
      number = create_number(n) |> IO.inspect(label: "number")
      count_letters(number) + acc
    end)
  end
end

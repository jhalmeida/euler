defmodule Nineteen do
  @moduledoc """
  You are given the following information, but you may prefer to do some research for yourself.

  1 Jan 1900 was a Monday.
  
  Thirty days has September,
  April, June and November.
  All the rest have thirty-one,
  Saving February alone,
  Which has twenty-eight, rain or shine.
  And on leap years, twenty-nine.
  
  A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
  
  How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
  """
  def february(year) do
    is_leap = case rem(year, 100) == 0 do
      true -> rem(year, 400) == 0
      false -> rem(year, 4) == 0
    end
    case is_leap do
      true -> {year, 29, 3}
      false -> {year, 28, 3}
    end
  end

  def next_month(2001, _, _, count), do: count
  def next_month(year, month, wd, count) do
    new_wd = rem(wd, 7)
    new_count = case new_wd == 0 and year > 1900 do
      true ->
        IO.inspect({year, month}, label: "sunday on first")
        count + 1

      false -> count
    end
    {y, d, m} = case month do
      1 -> {year, 31, 2}
      2 -> february(year)
      3 -> {year, 31, 4}
      4 -> {year, 30, 5}
      5 -> {year, 31, 6}
      6 -> {year, 30, 7}
      7 -> {year, 31, 8}
      8 -> {year, 31, 9}
      9 -> {year, 30, 10}
      10 ->{year, 31, 11}
      11 -> {year, 30, 12}
      12 -> {year + 1, 31, 1}
    end
    next_month(y, m, new_wd + d, new_count)
  end

  def solve do
    # Sun - Sat == 0 - 6
    # Jan - Dec == 1 - 12
    next_month(1900, 1, 1, 0)
  end
end

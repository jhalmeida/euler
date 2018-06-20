
defmodule Eleven do

  @doc """
    Takes and index, and a row. Returns the product of the
    four adjacent elements starting at the index.
  """
  def mult_4(index, row) do
    [a, b, c, d] = Enum.slice(row, index, 4)
    a * b * c * d
  end

  @doc """
    Termination for check_row/3 recursion. when index is > 16 the
    function terminates with the max. > 16 because rows are 20 elems
    and the product of 4 elements is needed for the max.
  """
  def check_row(index, _, max) when index > 16 do
    max
  end

  @doc """
    Takes and index, a row, and max as parameters and
    checks the product of the 4 elements starting from index
    updating the max when necessary.
  """
  def check_row(index, row, max) do
    product = mult_4(index, row)
    cond do
      product > max -> check_row(index + 1, row, product)
      true -> check_row(index + 1, row, max)
    end
  end

  @doc """
    accepts a list of lists, and a max as parameters and
    finds the maximum product of any four adjacent elements
    in the rows, storing a new max value and
  """
  def check_rows(rows, max) do
    Enum.reduce(rows,  max, fn(row, acc) ->
      val = check_row(0, row, acc)
      cond do
        val > acc ->
          val
        true ->
          acc
      end
    end)
  end

  @doc """
    Creates an offset row, by adding the index number of zeros to
    the left side of the row and 19 - index number of zeros to the
    right side of the row.
  """
  def offset_row(row, index) do
    offset_l = List.duplicate(0, index)
    offset_r = List.duplicate(0, 19 - index )
    offset_l ++ row ++ offset_r
  end

  @doc """
    Termination for the make_diagonals recursion. Once finished offsetting
    the rows, the function returns the transposed rows, simulating a diagonal line
    up of the matrix.
  """
  def make_diagonals(matrix, index \\ 0, diagonals \\ [] )
  def make_diagonals([], _, diagonals) do
    #IO.inspect(List.first(diagonals), label: "list first")
    transpose(diagonals)
  end

  @doc """
    Function accepts a list of lists, index, and updated diagonal lists.
    Keeping an index the function iterates through all the lists, offsetting
    each row with zeros according to the index of the function.
  """
  def make_diagonals([head | rest], index, diagonals) do
     offset_row = offset_row(head, index ) #|> IO.inspect(label: "offsetting index: #{index}")
     make_diagonals(rest, index + 1, diagonals ++ [offset_row])
  end

  @doc """
    Takes a matrix (list of lists), zips the lists creating
    a list of tuples, each tuple containing elements from
    the same index from each of the lists. Then converts those
    tuples back to lists, transposing the matrix.
  """
  def transpose(rows) do
    rows
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
  end


  @doc """
    Finds the maximum product of four adjacent elements in the given matrix.
  """
  def find_max() do
    start_time = :os.system_time(:milli_seconds) #|> IO.inspect(label: "start_time")
    matrix = [
      ~w(08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08) |> Enum.map(&String.to_integer/1),
      ~w(49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00) |> Enum.map(&String.to_integer/1),
      ~w(81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65) |> Enum.map(&String.to_integer/1),
      ~w(52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91) |> Enum.map(&String.to_integer/1),
      ~w(22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80) |> Enum.map(&String.to_integer/1),
      ~w(24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50) |> Enum.map(&String.to_integer/1),
      ~w(32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70) |> Enum.map(&String.to_integer/1),
      ~w(67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21) |> Enum.map(&String.to_integer/1),
      ~w(24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72) |> Enum.map(&String.to_integer/1),
      ~w(21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95) |> Enum.map(&String.to_integer/1),
      ~w(78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92) |> Enum.map(&String.to_integer/1),
      ~w(16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57) |> Enum.map(&String.to_integer/1),
      ~w(86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58) |> Enum.map(&String.to_integer/1),
      ~w(19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40) |> Enum.map(&String.to_integer/1),
      ~w(04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66) |> Enum.map(&String.to_integer/1),
      ~w(88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69) |> Enum.map(&String.to_integer/1),
      ~w(04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36) |> Enum.map(&String.to_integer/1),
      ~w(20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16) |> Enum.map(&String.to_integer/1),
      ~w(20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54) |> Enum.map(&String.to_integer/1),
      ~w(01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48) |> Enum.map(&String.to_integer/1),
    ]

      columns = transpose(matrix) #|> IO.inspect(label: "columns")

      left_diag = make_diagonals(matrix)

      right_diag = transpose(columns) |> make_diagonals #|> IO.inspect(label: "Right diag")

      matrix_permutations = matrix ++ columns ++ left_diag ++ right_diag

      max = check_rows(matrix_permutations, 0)

      end_time = :os.system_time(:milli_seconds) #|> IO.inspect(label: "end_time")
      IO.inspect(max, label: "elapsed time: #{end_time - start_time} milliseconds; max product")
  end
end


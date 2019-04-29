defmodule Fiftyfour do
  @moduledoc """
  In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

  High Card: Highest value card.
  One Pair: Two cards of the same value.
  Two Pairs: Two different pairs.
  Three of a Kind: Three cards of the same value.
  Straight: All cards are consecutive values.
  Flush: All cards of the same suit.
  Full House: Three of a kind and a pair.
  Four of a Kind: Four cards of the same value.
  Straight Flush: All cards are consecutive values of same suit.
  Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
  The cards are valued in the order:
  2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

  If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.

  Consider the following five hands dealt to two players:

  Hand    Player 1    Player 2    Winner
  1   5H 5C 6S 7S KD
  Pair of Fives
    2C 3S 8S 8D TD
  Pair of Eights
    Player 2
  2   5D 8C 9S JS AC
  Highest card Ace
    2C 5C 7D 8S QH
  Highest card Queen
    Player 1
  3   2D 9C AS AH AC
  Three Aces
    3D 6D 7D TD QD
  Flush with Diamonds
    Player 2
  4   4D 6S 9H QH QC
  Pair of Queens
  Highest card Nine
    3D 6D 7H QD QS
  Pair of Queens
  Highest card Seven
    Player 1
  5   2H 2D 4C 4D 4S
  Full House
  With Three Fours
    3C 3D 3S 9S 9D
  Full House
  with Three Threes
    Player 1
  The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.

  How many hands does Player 1 win?
  """
  def format_rows(rows) do
    rows
    |> String.trim()
    |> String.split(" ")
  end

  def get_data(file \\ "lib/p054_poker.txt") do
    File.read!(file)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn(rows) -> format_rows(rows) end)
  end

  def convert_value(value) do
    case value do
      "2" -> 2
      "3" -> 3
      "4" -> 4
      "5" -> 5
      "6" -> 6
      "7" -> 7
      "8" -> 8
      "9" -> 9
      "T" -> 10
      "J" -> 11
      "Q" -> 12
      "K" -> 13
      "A" -> 14
    end
  end

  def check_flush(hand) do
    suits =
      hand
      |> Enum.map(&(String.last(&1)))
      |> Enum.uniq()
      |> length()

    kicker =
      hand
      |> Enum.map(&(String.first(&1)))
      |> Enum.map(&(convert_value(&1)))
      |> Enum.sort(&(&1 >= &2))

    cond do
      suits == 1 -> {:ok, kicker}
      true -> nil
    end
  end

  def check_straight(hand) do
    values =
      hand
      |> Enum.map(&(String.first(&1)))
      |> Enum.map(&(convert_value(&1)))
      |> Enum.sort()

    match_straight = Enum.map([0, 1, 2, 3, 4], &(&1 + List.first(values)))
    cond do
      values == [2, 3, 4, 5, 14] -> {:ok, [5]}
      values == match_straight -> {:ok, [List.last(values)]}
      true -> nil
    end
  end

  def get_value_count(hand) do
    Enum.reduce(hand, %{}, fn (card, acc) ->
      card_value =
        card
        |> String.first()
        |> convert_value()

      count = Map.get(acc, card_value, 0)
      Map.put(acc, card_value, count + 1)
    end)
  end

  def straight_flush(hand) do
    with {:ok, _kicker_flush} <- check_flush(hand),
         {:ok, kicker_straight} <- check_straight(hand)
    do
      {:straight_flush, kicker_straight}
    else
      nil -> four_of_a_kind(hand)
    end
  end

  def four_of_a_kind(hand) do
    values = get_value_count(hand)

    max =
      values
      |> Map.values()
      |> Enum.sort()
      |> List.last()

    case max do
      4 ->
        [value1, value2] = Map.keys(values)
        kicker = cond do
          Map.get(values, value1) == 4 -> [value1, value2]
          Map.get(values, value2) == 4 -> [value2, value1]
        end
        {:four_of_a_kind, kicker}

      _ ->
        full_house(hand)
    end
  end

  def full_house(hand) do
    values = get_value_count(hand)
    case map_size(values) do
      2 ->
        [value1, value2] = Map.keys(values)
        kicker = cond do
          Map.get(values, value1) == 3 -> [value1, value2]
          Map.get(values, value2) == 3 -> [value2, value1]
        end
        {:full_house, kicker}

      _ ->
        flush(hand)
    end
  end

  def flush(hand) do
    with {:ok, kicker} <- check_flush(hand) do
      {:flush, kicker}
    else
      nil -> straight(hand)
    end
  end

  def straight(hand) do
    with {:ok, kicker} <- check_straight(hand) do
      {:straight, kicker}
    else
      nil -> three_of_a_kind(hand)
    end
  end

  def three_of_a_kind(hand) do
    values = get_value_count(hand)

    max =
      values
      |> Map.values()
      |> Enum.sort()
      |> List.last()

    case max do
      3 ->
        [value1, value2, value3] = Map.keys(values)
        kicker = cond do
          Map.get(values, value1) == 3 ->
            case value2 > value3 do
              true -> [value1, value2, value3]
              false -> [value1, value3, value2]
            end

          Map.get(values, value2) == 3 ->
            case value1 > value3 do
              true -> [value2, value1, value3]
              false -> [value2, value3, value1]
            end

          Map.get(values, value3) == 3 ->
            case value1 > value2 do
              true -> [value3, value1, value2]
              false -> [value3, value2, value1]
            end
        end
        {:three_of_a_kind, kicker}

      _ ->
        two_pairs(hand)
    end
  end

  def two_pairs(hand) do
    values = get_value_count(hand)

    case map_size(values) do
      3 ->
        [value1, value2, value3] = Map.keys(values)
        kicker = cond do
          Map.get(values, value1) == 1 ->
            case value2 > value3 do
              true -> [value2, value3, value1]
              false -> [value3, value2, value1]
            end

          Map.get(values, value2) == 1 ->
            case value1 > value3 do
              true -> [value1, value3, value2]
              false -> [value3, value1, value2]
            end

          Map.get(values, value3) == 1 ->
            case value1 > value2 do
              true -> [value1, value2, value3]
              false -> [value2, value1, value3]
            end
        end
        {:two_pairs, kicker}

      _ ->
        one_pair(hand)
    end
  end

  defp one_pair_kicker_list(values, value) do
    values
    |> Map.drop([value])
    |> Map.keys()
    |> Enum.sort(&(&1 >= &2))
    |> List.insert_at(0, value)
  end

  def one_pair(hand) do
    values = get_value_count(hand)
    case map_size(values) do
      4 ->
        [value1, value2, value3, value4] = Map.keys(values)
        kicker = cond do
          Map.get(values, value1) == 2 -> one_pair_kicker_list(values, value1)
          Map.get(values, value2) == 2 -> one_pair_kicker_list(values, value2)
          Map.get(values, value3) == 2 -> one_pair_kicker_list(values, value3)
          Map.get(values, value4) == 2 -> one_pair_kicker_list(values, value4)
        end
        {:one_pair, kicker}

      _ ->
        high_card(hand)
    end
  end

  def high_card(hand) do
    values =
      hand
      |> Enum.map(&(String.first(&1)))
      |> Enum.map(&(convert_value(&1)))
      |> Enum.sort(&(&1 >= &2))

    {:high_card, values}
  end

  def find_highest_hand(hand) do
    straight_flush(hand)
  end

  def get_hand(hand) do
    case find_highest_hand(hand) do
      {:straight_flush, kicker} -> {1, kicker}
      {:four_of_a_kind, kicker} -> {2, kicker}
      {:full_house, kicker} -> {3, kicker}
      {:flush, kicker} -> {4, kicker}
      {:straight, kicker} -> {5, kicker}
      {:three_of_a_kind, kicker} -> {6, kicker}
      {:two_pairs, kicker} -> {7, kicker}
      {:one_pair, kicker} -> {8, kicker}
      {:high_card, kicker} -> {9, kicker}
    end
  end

  def check_kicker([], []), do: :draw

  def check_kicker(kicker1, kicker2) do
    [k1 | tail1] = kicker1
    [k2 | tail2] = kicker2
    cond do
      k1 > k2 -> :hand1
      k2 > k1 -> :hand2
      k1 == k2 -> check_kicker(tail1, tail2)
    end
  end

  def winner_check(hand1, hand2) do
    {hand1_value, hand1_kicker} = hand1
    {hand2_value, hand2_kicker} = hand2
    IO.inspect(%{hand1: [hand1_value, hand1_kicker], hand2: [hand2_value, hand2_kicker]}, label: "winner check")
    cond do
      hand1_value < hand2_value -> :hand1
      hand1_value > hand2_value -> :hand2
      hand1_value == hand2_value -> check_kicker(hand1_kicker, hand2_kicker)
    end
  end

  def solution do
    data = get_data()
    Enum.reduce(data, {0, 0}, fn(row, score) ->
      {hand1_score, hand2_score} = score
      hand1 = Enum.slice(row, 0..4) |> get_hand()
      hand2 = Enum.slice(row, 5..9) |> get_hand()
      case winner_check(hand1, hand2) do
        :hand1 ->
          IO.inspect({hand1_score + 1, hand2_score}, label: "hand1 wins")
          {hand1_score + 1, hand2_score}
        :hand2 ->
          IO.inspect({hand1_score, hand2_score + 1}, label: "hand2 wins")
          {hand1_score, hand2_score + 1}
        :draw ->
          IO.inspect({hand1_score, hand2_score}, label: "split pot")
          {hand1_score, hand2_score}
      end
    end)
  end
end

defmodule MergeSort do
  # Hmmm.... Implemented a sorting alg in Clojure that leveraged
  # divide and conquer... yet I had tries three times to implement merge sort here?...
  def merge_sort(list) do
    list_len = length(list)

    case list_len <= 1 do
      true ->
        list

      _ ->
        mid = round(length(list) / 2)
        {first_half, second_half} = Enum.split(list, mid)

        # NOTE TO SELF -> see how this merge is implemented.... Because all of my recursive efforts
        # have been highly disappointing.
        # The SO links -> https://stackoverflow.com/questions/38417212/performance-improvement-in-elixir-when-using-lists/44997959#44997959
        # AND the erlang src code for :lists.merge -> https://github.com/erlang/otp/blob/master/lib/stdlib/src/lists.erl#L565
        # :lists.merge(merge_sort(first_half), merge_sort(second_half))
        # My attempt before seeing the SO post that uses the :lists module above
        sort([], merge_sort(first_half), merge_sort(second_half))
    end
  end

  def sort(acc, [first_head | first_tail], [second_head | second_tail]) do
    cond do
      first_head < second_head ->
        sort([first_head, second_head | acc], first_tail, second_tail)

      second_head < first_head ->
        sort([second_head, first_head | acc], first_tail, second_tail)

      true ->
        acc
    end
  end

  def sort(acc, [head | tail], []) do
    IO.puts("acc, [head | tail], []")
    Enum.reverse([head | [tail | acc]])
  end

  def sort(acc, [], [head | tail]) do
    IO.puts("acc, [], [head | tail]")
    Enum.reverse([head | [tail | acc]])
  end

  def sort(acc, [], []) do
    IO.puts("acc, [], []")
    result = Enum.reverse(acc)
    IO.puts("the result being returned")
    IO.inspect(result)
    result
  end
end

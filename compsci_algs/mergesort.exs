defmodule MergeSort do
  def run_it(list) do
    merge_sort(list)
  end

  # def merge_sort([head | tail]) when length(tail) === 1 do
  #   IO.puts("tail is of length 1 in recursive merge_sort call, starting to merge.")
  #   IO.puts("Head")
  #   IO.inspect(head)
  #   IO.puts("Head")
  #   IO.inspect(tail)
  #   merge([head], tail)
  # end

  def merge_sort(list) when is_list(list) do
    case length(list) < 2 do
      true ->
        IO.puts("returning list")
        IO.inspect(list)
        list

      _ ->
        mid = round(length(list) / 2)
        {first_half, second_half} = Enum.split(list, mid)
        IO.puts("split list in merge_sort")
        IO.inspect(first_half)
        IO.inspect(second_half)
        merge([], merge_sort(first_half), merge_sort(second_half))
    end
  end

  # def merge(first_list, second_list) when is_list(first_list) and is_list(second_list) do
  #   IO.puts("First call to sort")
  #   IO.inspect(first_list)
  #   IO.inspect(second_list)
  #   sort([], first_list, second_list)
  # end

  def merge(acc, [first_head | []], [second_head | []]) do
    IO.puts("Second call to merge")

    cond do
      first_head < second_head ->
        IO.puts(first_head)
        IO.puts(second_head)
        [first_head, second_head | acc]

      second_head < first_head ->
        IO.puts(second_head)
        IO.puts(first_head)
        [second_head, first_head | acc]
    end
  end

  def merge(acc, [first_head | first_tail], [second_head | second_tail])
      when first_head < second_head do
    IO.puts("Third call to merge")
    IO.puts(first_head)
    IO.puts(second_head)

    [first_head, second_head | acc]
    |> merge(first_tail, second_tail)
  end

  def merge(acc, [first_head | first_tail], [second_head | second_tail])
      when second_head < first_head do
    IO.puts("Fourth call to merge")
    IO.puts(second_head)
    IO.puts(first_head)

    [second_head, first_head | acc]
    |> merge(first_tail, second_tail)
  end
end

# list = [ 2, 5, 1, 29, 13, 95, 100, 23]

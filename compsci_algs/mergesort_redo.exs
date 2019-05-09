defmodule MergeSort do
  def merge_sort(list) when is_list(list) and length(list) < 2 do
    IO.puts("list is less than 2")
    list
  end

  def merge_sort(list) when is_list(list) do
    IO.puts("it's greater than two")
    mid = round(length(list) / 2)
    {first_half, second_half} = Enum.split(list, mid)
    IO.puts("split list in merge_sort")
    IO.inspect(first_half)
    IO.inspect(second_half)
    sort([], merge_sort(first_half), merge_sort(second_half))
  end

  def sort(_acc, first_half, second_half) do
    IO.puts("first sort call")
    IO.inspect(first_half)
    IO.inspect(second_half)

    # sort(acc, first_half, second_half)
  end

  # def sort(acc, [first_head | []], [second_head | []]) do
  #   IO.puts("The first effed up sort is hit")
  # end

  # def sort(acc, [first_head | first_tail], [second_head | []]) do
  #   IO.puts("The second effed up sort is hit")
  # end

  # def sort(acc, [first_head | []], [second_head | second_tail]) do
  #   IO.puts("The third effed up sort is hit")
  # end

  # def sort(acc, [first_head | first_tail], [second_head | second_tail])
  #     when first_head < second_head do
  #   acc =
  #     List.insert_at(acc, -1, first_head)
  #     |> List.insert_at(-1, second_head)

  #   sort(acc, first_tail, second_tail)
  # end

  # def sort(acc, [first_head | first_tail], [second_head | second_tail])
  #     when second_head < first_head do
  #   acc =
  #     List.insert_at(acc, -1, second_head)
  #     |> List.insert_at(-1, first_head)

  #   sort(acc, first_tail, second_tail)
  # end
end

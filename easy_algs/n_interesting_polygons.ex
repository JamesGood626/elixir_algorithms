def shape_area(n) do
  # Start from 1 and recurse up to n
  # Have an accumulator value for the n - 1 interesting polygon:
  # i.e. if the current iteration value of n is 1 the area will just be 1.
  # but when n is 2 the area will be 5 because 2 - 1 = 1 and one addtional block
  # will be appended on all four sides of the previous area, and so on and so forth.
  iterate_up_to_n(1, n, 0)
end

def iterate_up_to_n(iter_count, n, acc) do
  cond do
    iter_count <= n ->
      acc = add_blocks(iter_count, acc)
      iterate_up_to_n(iter_count + 1, n, acc)

    iter_count > n ->
      acc
  end
end

def add_blocks(current_n, acc) do
  # The amount of blocks to add on all four sides
  added_blocks =
    cond do
      current_n == 1 ->
        1

      true ->
        (current_n - 1) * 4
    end

  acc + added_blocks
end

defmodule RotateImage do
  def rotateImage(a) do
    process_lists([], a)
  end

  def process_lists(acc, [head | []]) do
    create_rotated_list(acc, head)
  end

  def process_lists(acc, [head | tail]) do
    # Create a function that will take the first list and
    # place each el in the acc list i.e. [1,2,3] -> [[1], [2], [3]]
    # So that you may continue to recursively call process_lists w/
    # the updated acc list & and remainder tail list -> [[4,5,6], [7,8,9]]
    create_rotated_list(acc, head)
    |> process_lists(tail)
  end

  def create_rotated_list(acc, [head | []]) do
    [acc, [head]]
  end

  def create_rotated_list(acc, [head | tail]) do
    [acc, [head]]
    |> create_rotated_list(tail)
  end
end

# input
a = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
# output

finalResult = [[7, 4, 1], [8, 5, 2], [9, 6, 3]]

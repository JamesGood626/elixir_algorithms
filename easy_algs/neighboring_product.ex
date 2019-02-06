def adjacentElementsProduct(inputArray) do
  result =
    iterate_list(inputArray, [])
    |> Enum.sort()
    |> IO.inspect()
    |> Enum.take(-1)
    |> Enum.at(0)
end

def iterate_list([head | [head_two | tail]], product_list) do
  product_list = [calculate_product(head, head_two) | product_list]
  iterate_list([head_two | tail], product_list)
end

def iterate_list([head | []], product_list) do
  product_list
end

def calculate_product(num_one, num_two), do: num_one * num_two

# This was the first attempt, a overcomplicated way of attempting to accomplish this...
# def adjacentElementsProduct(inputArray) do
#   determine_difference(inputArray, %{difference: nil, num_one: nil, num_two: nil})
# end

# def determine_difference(
#       [head | [head_two | tail]],
#       %{:difference => nil, :num_one => nil, :num_two => nil} = state
#     ) do
#   state =
#     (head - head_two)
#     |> update_state(head, head_two, state)

#   determine_difference([head_two | tail], state)
# end

# def determine_difference([head | [head_two | tail]], state) do
#   state =
#     cond do
#       head < 0 and head_two < 0 and head < head_two ->
#         calculate_difference(abs(head), abs(head_two))
#         |> compare_against_state(abs(head), abs(head_two), state)

#       head < 0 and head_two < 0 and head_two < head ->
#         calculate_difference(abs(head_two), abs(head))
#         |> compare_against_state(abs(head_two), abs(head), state)

#       head > head_two ->
#         calculate_difference(head, head_two)
#         |> compare_against_state(head, head_two, state)

#       head_two > head ->
#         calculate_difference(head_two, head)
#         |> compare_against_state(head_two, head, state)
#     end

#   determine_difference([head_two | tail], state)
# end

# def determine_difference([head | tail], %{:num_one => num_one, :num_two => num_two} = _state) do
#   calculate_product(num_one, num_two)
# end

# def calculate_difference(num_one, num_two) when num_one > num_two, do: num_one - num_two
# def calculate_difference(num_one, num_two) when num_two > num_one, do: num_two - num_one

# def calculate_product(num_one, num_two), do: num_one * num_two

# def compare_against_state(difference, head, head_two, state) do
#   cond do
#     head_two == state.num_two and head > state.num_one ->
#       update_state(difference, head, head_two, state)

#     state.difference < 0 ->
#       update_state(difference, head, head_two, state)

#     difference < state.difference ->
#       update_state(difference, head, head_two, state)

#     true ->
#       state
#   end
# end

# def update_state(difference, head, head_two, state) do
#   cond do
#     head > head_two ->
#       %{state | :difference => difference, :num_one => head, :num_two => head_two}

#     head_two > head ->
#       %{state | :difference => difference, :num_one => head_two, :num_two => head}
#   end
# end

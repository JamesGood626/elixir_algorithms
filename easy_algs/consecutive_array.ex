def makeArrayConsecutive2(statues) do
  sort_min_max_length(statues)
end

def sort_min_max_length(statues) do
  sorted = Enum.sort(statues)
  min = Enum.take(sorted, 1) |> Enum.at(0)
  max = Enum.take(sorted, -1) |> Enum.at(0)
  range = max - min
  length = length(sorted)
  # final answer
  range - length + 1
end

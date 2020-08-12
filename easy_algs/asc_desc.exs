# write a function that takes in an array and an int (always > 1)
# determine how the start of every valid run in an array
# a run is defined as as a sequence of integers that are increasing or decreasing by a difference of 1 between each
# a run can only be asceding or desceding
# examples:
#  asc run  [1,2,3]
#  desc run [3,2,1]
# non runs
# [1,2,1]

# arr = [1, 2, 3, 5, 6, 9, 10, 11, 12, 11, 10]
# n = 3
# print(find_n_runs(arr, n))  # expect [0,5,6,8]
# print(find_n_runs([1, 2], 4))  # expect None
defmodule DsAlgo do
  # def find_n_runs(list, n) do
  #   start = 0
  #   # finish = 0 + n
  #   dir_key = nil # :asc, :desc
  #   tmp_list = []
  #   list
  #   |> Enum.with_index
  #   |> Enum.reduce([], fn {el, idx}, acc ->
  #     IO.puts("the tmp_list")
  #     # IO.inspect(tmp_list)
  #     IO.puts(idx)
  #     if dir_key === nil do
  #       if tmp_list |> length === 1 do
  #         # assgin dir_key after determining :asc or :desc
  #         first_el = tmp_list |> Enum.at(0)
  #         # Determine if there's potentially acs desc case to check for:
  #         if abs(el - first_el) === 1 do
  #           if el < first_el do
  #             dir_key = :asc
  #             tmp_list = [first_el, el]
  #           else
  #             dir_key = :desc
  #             tmp_list = [first_el, el]
  #           end
  #         else
  #           # There was no potentially asc/desc case.
  #           tmp_list = []
  #         end
  #       else
  #         # Starting over again after determining:
  #         # - valid asc/desc case
  #         # - or first time through this loop
  #         IO.puts("REASSIGNING tmp_list")
  #         tmp_list |> IO.inspect
  #         tmp_list = [el | tmp_list]
  #         tmp_list |> IO.inspect
  #       end

  #       acc # no updates required as no asc/desc case has been met yet
  #     else
  #       case dir_key do
  #         :asc ->
  #           # reduce should continue looping while dir_key === :asc
  #           # and elements of the list continue to satisfy the :asc invariants
  #           # up until we reach tmp_list |> length === n
  #           # at which point, we update acc with start and end (which is idx)
  #           len = tmp_list |> length
  #           last_el = tmp_list |> Enum.at(len)
  #           if last_el - el === -1 do
  #             if [el | tmp_list] |> length === n do
  #               # reverse it and flatten it after all of reduce is finished
  #               [[start, idx] | acc]

  #               # [0,5,6,8]
  #             else
  #               # we continue checking :asc case on next loop iteration
  #               [tmp_list | [el]] |> List.flatten
  #               acc
  #             end
  #           else
  #            # reset
  #            tmp_list = []
  #            dir_key = nil
  #            acc # with updates if tmp_list |> length === n else acc not updated
  #           end

  #         :desc ->
  #           len = tmp_list |> length
  #           last_el = tmp_list |> Enum.at(len)
  #           if last_el - el === 1 do
  #             if [el | tmp_list] |> length === n do
  #               [[start, idx] | acc]
  #             else
  #               # we continue checking :desc case on next loop iteration
  #               [tmp_list | [el]] |> List.flatten
  #               acc
  #             end
  #           else
  #            # reset
  #            tmp_list = []
  #            dir_key = nil
  #            acc # with updates if tmp_list |> length === n else acc not updated
  #           end
  #       end
  #     end
  #   end)
  # end

  # def find_n_runs(list, n, idx_list \\ [], accum_list \\ [], dir_key \\ nil, old_n \\ nil) do
  #   case dir_key do
  #     :asc ->
  #       [c | xs] = list
  #       # whenever n === 0 (then we also have a), we continue forward with where we're at in the list
  #       # with another recursive call to find_n_runs without a dir_key
  #       len = accum_list |> length
  #       last_el = accum_list |> Enum.at(len)
  #       if c - last_el === 1 do
  #       else
  #         find_n_runs(xs, old_n)
  #       end

  #     :desc ->
  #       # whenever n === 0
  #       [c | xs] = list
  # len = accum_list |> length
  # last_el = accum_list |> Enum.at(len)
  # if last_el - c === 1 do

  # else
  #         find_n_runs(xs, old_n)
  #       end
  #   end

  #   # 1. check first and second el and determine if difference is 1
  #   if Math.abs(a - b) === 1 do
  #     # 2. determine direction--whether asc or desc
  #     if a < b do
  #       # asc check
  #       # 3. recursive call compare next element in list with the last element of the accumulator list
  #       find_n_runs(reduced_list, n - 1, [a, b | accum_list], :asc, n)
  #     else
  #       # desc check
  #       # 3. recursive call compare next element in list with the last element of the accumulator list
  #       find_n_runs(reduced_list, n - 1, [a, b | accum_list], :desc, n)
  #     end
  #   end
  # end

  def find_n_runs(list, n) do
    helper(list, n, %{"idx" => 0, "dir" => nil, "run" => [], "run_len" => 0})
  end

  def helper(_, n, %{"run" => run, "run_len" => run_len} = _aux) when run_len === n do
    run |> Enum.reverse()
  end

  def helper([x | [y | xs]], n, %{"dir" => nil} = aux) do
    delta = abs(x - y)

    if delta === 1 do
      aux = aux |> add_to_run(Map.get(aux, "idx")) |> incr_run_len |> incr_idx

      # I've been criminally underusing cond in this manner:
      # https://elixir-lang.org/getting-started/case-cond-and-if.html#cond
      cond do
        x < y ->
          helper([y | xs], n, aux |> set_dir(:asc))

        x > y ->
          helper([y | xs], n, aux |> set_dir(:desc))
      end
    else
      helper([y | xs], n, incr_idx(aux))
    end
  end

  def helper([x | [y | xs]], n, %{"dir" => :asc} = aux), do: check(:asc, {x, y, xs}, n, aux)
  def helper([x | [y | []]], n, %{"dir" => :asc} = aux), do: check(:asc, {x, y, []}, n, aux)
  def helper([x | [y | xs]], n, %{"dir" => :desc} = aux), do: check(:desc, {x, y, xs}, n, aux)
  def helper([x | [y | []]], n, %{"dir" => :desc} = aux), do: check(:desc, {x, y, []}, n, aux)

  def check(:asc, {x, y, xs}, n, aux), do: check(y - x, {x, y, xs}, n, aux)
  def check(:desc, {x, y, xs}, n, aux), do: check(x - y, {x, y, xs}, n, aux)

  def check(delta, {x, y, xs}, n, aux) when is_integer(delta) do
    if delta === 1 do
      aux = aux |> add_to_run(Map.get(aux, "idx")) |> incr_run_len |> incr_idx
      helper([y | xs], n, aux)
    else
      aux = aux |> add_to_run([]) |> reset_run_len |> set_dir(nil) |> incr_idx
      helper([y | xs], n, aux)
    end
  end

  def check(delta, _, _n, _aux), do: throw("Invalid value passed to check: delta - #{delta}")

  def incr_run_len(aux) do
    {_, aux} =
      Map.get_and_update!(aux, "run_len", fn current_value ->
        {current_value, current_value + 1}
      end)

    aux
  end

  def reset_run_len(aux) do
    {_, aux} =
      Map.get_and_update!(aux, "run_len", fn current_value ->
        {current_value, 0}
      end)

    aux
  end

  def add_to_run(aux, []) do
    {_, aux} =
      Map.get_and_update!(aux, "run", fn current_value ->
        {current_value, []}
      end)

    aux
  end

  def add_to_run(aux, x) do
    {_, aux} =
      Map.get_and_update!(aux, "run", fn current_value ->
        {current_value, [x | current_value]}
      end)

    aux
  end

  def set_dir(aux, dir) do
    {_, aux} =
      Map.get_and_update!(aux, "dir", fn _current_value ->
        {nil, dir}
      end)

    aux
  end

  def incr_idx(aux) do
    {_, aux} =
      Map.get_and_update!(aux, "idx", fn current_value ->
        {current_value, current_value + 1}
      end)

    aux
  end

  def run() do
    list = [1, 2, 3, 5, 6, 9, 10, 11, 12, 11, 10]
    result = find_n_runs(list, 3)
    IO.puts("the return result:")
    result |> IO.inspect()
  end
end

DsAlgo.run()

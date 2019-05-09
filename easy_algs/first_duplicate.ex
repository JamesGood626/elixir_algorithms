defmodule FirstDupe do
  def firstDuplicate(a) do
    Enum.reduce(a, %{index: 0}, fn num, acc -> detect_dupes(num, acc) end)
    |> check_dupes
    |> determine_result
  end

  def detect_dupes(num, acc) do
    acc =
      case Map.has_key?(acc, num) do
        true ->
          {_, acc} = check_if_first_duplicate(acc, num)

          acc

        false ->
          Map.put_new(acc, num, %{recent_index: acc.index, duplicate: false})
      end

    {_, acc} =
      Map.get_and_update!(acc, :index, fn current_val ->
        {current_val, current_val + 1}
      end)

    acc
  end

  def check_if_first_duplicate(acc, num) do
    case acc[num].duplicate === true do
      true ->
        {:ok, acc}

      false ->
        Map.get_and_update!(acc, num, fn current_val ->
          {current_val, %{recent_index: acc.index, duplicate: true}}
        end)
    end
  end

  def check_dupes(list) do
    Enum.filter(list, fn {_key, map} -> duplicate(map) end)
  end

  def duplicate(num) when is_integer(num) do
    false
  end

  def duplicate(map) when is_map(map) do
    case Map.has_key?(map, :duplicate) do
      true ->
        map.duplicate

      _ ->
        false
    end
  end

  def determine_result(list) when length(list) > 0 do
    {num, _} = Enum.min_by(list, fn {_num, %{recent_index: index}} -> index end)
    num
  end

  def determine_result(_list) do
    -1
  end
end

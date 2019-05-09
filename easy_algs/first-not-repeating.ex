defmodule NotRepeat do
  def firstNotRepeatingCharacter(s) do
    s
    |> map_string
    |> retrieve_non_repeating
    |> determine_result
  end

  def map_string(str) do
    str
    |> String.graphemes()
    |> Enum.reduce(%{index: 0, non_repeating: %{}, repeating: %{}}, fn char, acc ->
      mark_characters(char, acc)
    end)
  end

  def mark_characters(char, acc) do
    acc =
      case Map.has_key?(acc.non_repeating, char) do
        true ->
          mark_char_as_repeating(acc, char)

        false ->
          check_char_not_in_repeating(acc, char)
      end

    increment_index(acc)
  end

  def retrieve_non_repeating(map) do
    map.non_repeating
  end

  def check_char_not_in_repeating(acc, char) do
    case Map.has_key?(acc.repeating, char) do
      true ->
        acc

      false ->
        mark_char_as_non_repeating(acc, char)
    end
  end

  def mark_char_as_repeating(acc, char) do
    Map.update!(acc, :non_repeating, fn value -> remove_char(value, char) end)
    |> Map.update!(:repeating, fn value -> add_char_to_repeating(value, char) end)
  end

  def mark_char_as_non_repeating(acc, char) do
    Map.update!(acc, :non_repeating, fn value ->
      add_char_to_non_repeating(value, char, acc.index)
    end)

    # Map.get_and_update!(acc, :non_repeating, fn current_val ->
    #   IO.puts("current_val")
    #   IO.inspect(current_val)
    #   {current_val, Map.put_new(current_val, char, acc.index)}
    # end)
    # |> IO.inspect()
  end

  def remove_char(map, char) do
    Map.delete(map, char)
  end

  def add_char_to_non_repeating(map, char, index) do
    Map.put_new(map, char, index)
  end

  def add_char_to_repeating(map, char) do
    Map.put_new(map, char, true)
  end

  def increment_index(acc) do
    acc = Map.update!(acc, :index, fn value -> value + 1 end)
  end

  def determine_result(map) when map_size(map) === 0 do
    "_"
  end

  def determine_result(map) do
    %{char: char, index: _index} =
      Map.to_list(map)
      |> Enum.reduce(%{char: nil, index: nil}, fn tuple, acc ->
        determine_earliest_non_repeating(acc, tuple)
      end)

    char
  end

  def determine_earliest_non_repeating(acc, {char, index}) do
    case index < acc.index do
      true ->
        acc = %{acc | char: char, index: index}

      false ->
        acc
    end
  end
end

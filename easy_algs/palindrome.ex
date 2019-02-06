defmodule Palindrome do
  def checkPalindrome(inputString) do
    rStr =
      String.reverse(inputString)
      |> String.split("", trim: true)

    inputString = String.split(inputString, "", trim: true)
    compare(inputString, rStr)
  end

  def compare([headOne | tailOne], [headTwo | tailTwo]) do
    cond do
      headOne == headTwo -> compare(tailOne, tailTwo)
      headOne != headTwo -> false
    end
  end

  def compare([_headOne | []], [_headTwo | _tail]) do
    false
  end

  def compare([], []) do
    true
  end
end

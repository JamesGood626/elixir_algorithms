defmodule UkCounting do
  @moduledoc """
  Given a sequence of numbers
  and a target number,
  attempt to construct an expression whose value is the target,
  by combining one or more number from the sequence using
  addition, subtraction, multiplication, division and parentheses.

  Each number in the sequence can only be used at most once in the expression,
  and all of the numbers involved, including intermediate values, must be positive
  natural numbers (1, 2, 3,...).
  In particular, the use of negative numbers, zero, and proper fractions such as 2/3,
  is not permitted.

  For example, suppose that we are given
  the sequence [1, 3, 7, 10, 25, 50]
  and the target 765
  """
  @ADD "ADD"
  @SUBTRACT "SUBTRACT"
  @MULTIPLY "MULTIPLY"
  @DIVIDE "DIVIDE"

  # I think this is a greedy/backtracking alg...

  # The first thing that came to mind, was to first determine the calculation which
  # would yield a number closest to the number in target's left-most decimal position.

  # 50 * 10 = 500
  # 7 * 25 = 175
  # = 675
  #

  # or if you did 50 * 25 = 1250...

  # So if target is significantly less than what our current expression yields...
  # we need to multiply.
  # So if target is significantly higher than what our current expression yields...
  # we need to divide
  # if it's slightly less than our target...
  # we need to add
  # if it's slightly higher than our target...
  # we need to subtract
  def construct_expression(sequence, target) do
    # I think I'd need to use a map to set up a memoization of expressions which were already computed...
    # Because I'm thinking of utilizing some kind of combinatorial (i.e. we're three deep) loop over the number
    # and creating operations that way...
    # values in the memo map would be stored like:
    # key: "MULTIPLY_10_25"
    # value: 250

    # Probably not anywhere close to what the author of Programming in Haskell is going to attempt to do,
    # but I don't want to spend more time on this, as I want to hurry and get to Monads...
    end
  end

  def test() do
  end
end

UkCounting.test(765)

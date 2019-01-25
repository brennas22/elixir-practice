defmodule Practice.Factor do

  def factor(x) do
    # convert the incoming number to an integer
    # limit = String.to_integer(x)
    # start with an empty list of factors
    factorsList = []
    # start factors at 2
    factor = 2;
    # recursively find all factors
    findFactors(factorsList, factor, x)
  end

  def findFactors(factorsList, factor, num) do
    cond do
      # if reached last factor
      num == factor ->
        list = [num]
        factorsList = factorsList ++ list
        factorsList
      # if a factor
      rem(num, factor) == 0 ->
        factorsList = factorsList ++ [factor]
        num = div(num, factor)
        findFactors(factorsList, factor, num)
      # else (if not a factor and not a match)
      true ->
        factor = factor + 1
        findFactors(factorsList, factor, num)
    end
  end
end

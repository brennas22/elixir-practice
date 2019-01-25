defmodule Practice.Palindrome do

  def palindrome(word) do
    # get the length of the string
    length = String.length(word)
    half = div(length, 2)
    frontHalf = String.slice(word, 0..half-1)
    frontList = String.codepoints(frontHalf)

    # if the string length is even
    if (rem(length, 2) == 0) do
      # computeEven(word)
      backHalf = String.slice(word, half..length)
      computeMatch(word, frontList, backHalf)


    else #if the string length is odd
      backHalf = String.slice(word, half+1..length)
      computeMatch(word, frontList, backHalf)
    end




  end

  def computeMatch(word, frontList, backHalf) do
    backList = String.codepoints(backHalf)
    reversed = Enum.reverse(backList)

    if (frontList == reversed) do
      "is a palindrome"
    else
      "is not a palindrome"
    end


  end

end

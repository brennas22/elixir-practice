defmodule Practice.Calc do
  def parse_int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.

    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_postfix
    |> evaluate_expression
    # |> evaluate as a stack calculator using pattern matching
  end

  defp evaluate_expression(postfix_list, item_stack \\ []) do
    firstItem = List.first(postfix_list)
    case firstItem do
      nil -> item_stack[:num]
      {:num, _} -> evaluate_expression(tl(postfix_list), [firstItem | item_stack])
      {:operation, _} -> compute(postfix_list, item_stack)
    end
  end

  defp compute(postfix_list, item_stack) do
    operator = List.first(postfix_list) #operation
    topOfStack = List.first(item_stack)
    secondOfStack = List.first(tl(item_stack))
    # doCalculation(operator, secondOfStack, topOfStack)
    evaluate_expression(tl(postfix_list), [doCalculation(operator, secondOfStack, topOfStack) | tl(tl(item_stack))])
  end

  defp doCalculation(operator, first, second) do
    {:num, num1} = first #need to parseint?
    {:num, num2} = second
    {:operation, op} = operator
    #num1 = parse_int(f)
    #num2 = parse_int(s)
    case op do
      "+" -> {:num, num1 + num2}
      "-" -> {:num, num1 - num2}
      "/" -> {:num, num1 / num2}
      "*" -> {:num, num1 * num2}
    end
  end

  defp convert_postfix(itemList, operator_stack \\ [], postfix_list \\ []) do
    firstItem = List.first(itemList)
    case firstItem do
      nil -> Enum.reverse(postfix_list) ++ operator_stack
      {:num, _} -> convert_postfix(tl(itemList), operator_stack, [firstItem | postfix_list])
      {:operation, _} -> operation_logic(itemList, operator_stack, postfix_list)
    end
  end

  defp operation_logic(itemList, operator_stack, postfix_list) do
    firstItem = List.first(itemList)
    topOfOperatorStack = List.first(operator_stack)
    if topOfOperatorStack == nil do
      convert_postfix(tl(itemList), [firstItem | operator_stack], postfix_list)
    else
      if has_precedence(firstItem, topOfOperatorStack) do
        # take it off op stack and put it on postfix_list
        convert_postfix(tl(itemList), [firstItem | operator_stack], postfix_list)
      else
        operation_logic(itemList, tl(operator_stack), [topOfOperatorStack | postfix_list])
      end
    end
  end

  # determine the precendence of an operator
  defp precedence(operator) do
    {:operation, op} = operator
    case op do
      "+" -> 0
      "-" -> 0
      "/" -> 1
      "*" -> 1
    end
  end

  # true if operator 1 has precendence
  # false if operator 2 has precendence
  defp has_precedence(operator1, operator2) do
    precedence(operator1) > precedence(operator2)
  end

  defp tag_tokens(itemList) do
    if itemList == [] do
      itemList else
        [convert_string(hd(itemList)) | tag_tokens(tl(itemList))]
    end
  end

  defp convert_string(item) do
    case item do
      "+" -> {:operation, "+"}
      "-" -> {:operation, "-"}
      "/" -> {:operation, "/"}
      "*" -> {:operation, "*"}
      _ -> {:num, parse_int(item)}
    end
  end
end

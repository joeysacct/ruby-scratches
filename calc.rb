def solve_expression(expression)
  open_parens = expression.count("(")
  closing_parens = expression.count(")")
  if open_parens != closing_parens
    return "incorrect parentheticals."
  end

  if open_parens > 0 #if there are parentheses
    #solve deepest sub expression
    last_open_idx = expression.rindex("(")
    first_closed_idx = expression.index(")")
    sub_expr = expression[last_open_idx+1..first_closed_idx-1] #indices moved to remove wrapping parentheses
    sub_result = solve_expression(sub_expr)
    #replace sub expression in expression with result, and figure
    return solve_expression(expression.gsub("("+sub_expr+")", sub_result.to_s))
  else
    #if no parentheses, simply tokenize and solve
    tokenized_expression = expression.split(/([+,-,*,^,\/])/) #split expression on operators, () means the operators stay in the split

    #check operators are all correct
    tokenized_expression.each_with_index do |token,idx|
      next if idx == 0 #skip, this is checked by proxy of idx 1
      if token.match?(/[+,-,*,^,\/]/) #if operator
        #check to confirm tokens on both sides are numbers
        unless is_number?(tokenized_expression[idx-1]) && is_number?(tokenized_expression[idx+1])
          #if not, error
          return "improper operation around index #{idx}."
        end
      end
    end

    #establish order of operations
    exps = []
    mds = []
    sas = []
    tokenized_expression.each_with_index do |token,idx|
      case token
      when "^" then exps << idx
      when "*","/" then mds << idx
      when "+","-" then sas << idx
      end
    end
    temp_order = exps.reverse + mds + sas #exps reversed for right associativity!
    operation_order = []
    temp_order.each do |n|
      lesser_count = operation_order.count{|x| x < n }
      operation_order << n - 2*lesser_count
    end

    #complete each operation in order
    operation_order.each do |idx|
      operator = tokenized_expression[idx]
      #figure result of operation
      number_a = tokenized_expression[idx-1] == "ans" ? ans :  tokenized_expression[idx-1]
      number_b = tokenized_expression[idx+1] == "ans" ? ans :  tokenized_expression[idx+1]
      result = simple_calc(number_a.to_f, number_b.to_f, operator)

      #replace operation with result
      tokenized_expression[idx-1..idx+1] = result.to_s
    end

    return tokenized_expression[0].to_f
  end

end

def simple_calc(a,b,operator)
  if operator == "^"
    return a**b
  elsif operator == "*"
    return a * b
  elsif operator == "/"
    return a / b
  elsif operator == "+"
    return a + b
  elsif operator == "-"
    return a - b
  else
    raise "what"
  end
end

def is_number?(str)
  return true if str == "ans"
  return true if str =~ /\A\d+\Z/
  true if Float(str) rescue false
end

expression = ""
ans = 0
while expression != "quit"
  puts "Insert expression to be calculated i.e. '1+1'. type 'quit' to end program."
  expression = gets
  expression = expression.gsub(" ","").gsub("\n","").gsub("ans".to_s)

  ans = solve_expression(expression)
  puts ans
end
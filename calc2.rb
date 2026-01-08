Precedence = {
  "+" => 1,
  "-" => 1,
  "*" => 2,
  "/" => 2,
  "%" => 2,
  "^" => 3,
  'sin' => 3,
  'cos' => 3,
  'tan' => 3,
  'max' => 3,
  'min' => 3,
  'sqrt' => 3,
  "(" => 0,
  ")" => 0
}
Operands = ['+','-','*','/','^','%','(',')']
Functions = ['sin','cos','tan','max','min','sqrt']
Arg_Count = {
  'sin' => 1,
  'cos' => 1,
  'tan' => 1,
  'max' => 2,
  'min' => 2,
  'sqrt' => 1
}
def solve_expression(expression)
  open_parens = expression.count("(")
  closing_parens = expression.count(")")
  if open_parens != closing_parens
    return "incorrect parentheticals."
  end
  #convert to postfix notation
  postfix = []
  opstack = []
  tokens = expression.split(/([+,-,*,^,\/,\(,\),\,,%])/)
  tokens.each do |token|
    next if token.empty? || token == ","
    return "bad token '#{token}'" unless is_number?(token) || Operands.include?(token) || Functions.include?(token)
    if is_number?(token)
      postfix << token
    else

      stack_top = opstack.last
      if token == "("
        opstack << token
      elsif stack_top.nil? || Precedence[token] > Precedence[stack_top]
        opstack << token
      elsif Precedence[token] == Precedence[stack_top] && token != ")"
        postfix.push(stack_top)
        opstack.pop
        opstack << token
      elsif token == ")"
        while true
          if opstack.last == "("
            opstack.pop
            if Functions.include?(opstack.last)
              postfix << opstack.last
              opstack.pop
            end
            break
          else
            postfix << opstack.last
            opstack.pop
          end
        end
      end

    end

  end
  opstack.reverse.each{|op| postfix << op}
  # puts postfix.inspect
  # puts "evaluating..."
  i = 0
  while postfix.length > 1
    # puts postfix.inspect
    token = postfix[i]
    if Operands.include?(token) # if token is operator
      a = postfix[i-2].to_f
      b = postfix[i-1].to_f
      # puts "doing #{a} #{token} #{b}"
      postfix[i-2..i] = simple_eval(a,b,token).to_s
      i = 0
    elsif Functions.include?(token)
      args = Arg_Count[token]
      inputs = postfix[i-args..i-1].map{|n| n.to_f}
      # puts "eval #{token} on args #{inputs}"
      postfix[i-args..i] = func_eval(inputs,token).to_s
      i = 0
    elsif is_number?(token)
      i += 1
    else
      return "weird token #{token}"
    end
  end
  return postfix[0].to_f
end

def func_eval(inputs,func)
  case func
  when 'sin' then Math.sin(inputs[0])
  when 'cos' then Math.cos(inputs[0])
  when 'tan' then Math.tan(inputs[0])
  when 'max' then inputs.max
  when 'min' then inputs.min
  when 'sqrt' then Math.sqrt(inputs[0])
  end
end

def simple_eval(a,b,operator)
  case operator
  when "^" then a**b
  when "*" then a * b
  when "/" then a / b
  when "+" then a + b
  when "-" then a - b
  when "%" then a % b
  end
end

def is_number?(str)
  return true if str == "ans"
  return true if str =~ /\A\d+\Z/
  true if Float(str) rescue false
end

expression = ""
ans = 0
pi = 3.141592653589793238462
tau = 2*pi
while true
  puts "Insert expression to be calculated i.e. '1+1'. type 'quit' to end program."
  expression = gets
  expression = expression.
    gsub(" ","").
    gsub("\n","").
    gsub("ans",ans.to_s).
    gsub("pi",pi.to_s).
    gsub("tau",tau.to_s)
  break if expression == 'quit'
  ans = solve_expression(expression)
  puts ans
end
@value = {
  'amount' => 20.to_f
}

variable = @value['amount'].to_s.split(".")

print variable

if variable[1].size() < 2
  variable[1] << "0"
end

variable2 = variable.join(".")

print variable2

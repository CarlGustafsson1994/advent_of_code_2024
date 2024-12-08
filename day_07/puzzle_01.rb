equations = File.readlines("./input_07.txt", chomp: true).map do |line|
  res, nums = line.split(":")
  [res.to_i, nums.split(" ").map(&:to_i)]
end

equations.sum do |result, constants|
  operator_permutations = ["+", "*"].repeated_permutation(constants.length - 1)
  equation_valid = operator_permutations.any? do |permutation|
    sum = constants.first
    constants[1..-1].each_with_index do |right, index|
      sum = sum.send(permutation[index], right)
    end
    result == sum
  end
  equation_valid ? result : 0
end.tap { puts _1 }

rules, numbers = File.readlines("./input_05.txt", chomp: true).partition { |line| line.include?("|") }
rule_sets = rules.map { _1.split("|").map(&:to_i) }
updates = (numbers - [""]).map { _1.split(",").map(&:to_i) }
updates.inject(0) do |correct, update|
  relevant_rules = rule_sets.select { |rule_set| update.intersection(rule_set).count == 2 }
  correct += update[update.length / 2] if relevant_rules.reduce(true) do |valid, rule|
    valid && update.find_index(rule[0]) < update.find_index(rule[1])
  end
  correct
end.tap { puts _1 }

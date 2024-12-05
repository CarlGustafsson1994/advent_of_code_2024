joined_lines = File.readlines("./input.txt", chomp: true).join
joined_lines.scan(/mul\((\d{1,3}),(\d{1,3})\)/).reduce(0) do |sum, pair|
  sum += pair[0].to_i * pair[1].to_i
end.tap { |sum| puts sum }

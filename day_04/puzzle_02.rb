pad_arrays = ->(line_map) do
  line_map.map { |line| ["."] + line + ["."] }.unshift(["."] * (a.first.length + 2)).push(["."] * (a.first.length + 2))
end

x_mas = ->(line_map) do
  sum = 0
  column_triples = line_map.map { _1.each_cons(3).to_a }
  column_triples.each_cons(3) do |column_triple_subsection|
    transposed_subsection = column_triple_subsection.transpose
    transposed_subsection.each do |grid_of_three|
      middle = grid_of_three[1][1] == "A"
      top = grid_of_three[0][0] == "M" && grid_of_three[0][2] == "M"
      bottom = grid_of_three[2][0] == "S" && grid_of_three[2][2] == "S"
      top_reversed = grid_of_three[0][0] == "S" && grid_of_three[0][2] == "S"
      bottom_reversed = grid_of_three[2][0] == "M" && grid_of_three[2][2] == "M"
      sum += 1 if middle && ((top && bottom) || (top_reversed && bottom_reversed))
    end
  end
  sum
end

lines = File.readlines("./input_04.txt", chomp: true).map(&:chars)
lines_transposed = lines.transpose
padded_lines = pad_arrays.call(lines)
padded_lines_tranposed = pad_arrays.call(lines_transposed)
puts x_mas.call(padded_lines) + x_mas.call(padded_lines_tranposed)

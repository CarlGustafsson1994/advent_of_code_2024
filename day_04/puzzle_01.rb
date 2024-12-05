diagonal = ->(a) do
  padding = [*0..(a.length - 1)].map { |i| [nil] * i }
  filled_padded_arrays = padding.reverse.zip(a).zip(padding).map(&:flatten)
  filled_padded_arrays.transpose.map(&:compact)
end
lines = File.readlines("./input_04.txt", chomp: true).map(&:chars)
line_collections = [lines, lines.transpose, diagonal.call(lines), diagonal.call(lines.reverse)]
line_collections.map.inject(0) do |sum, arr|
  sum += arr.map(&:join).map { _1.scan(/(?=(XMAS|SAMX))/).count }.sum
end.tap { puts _1 }

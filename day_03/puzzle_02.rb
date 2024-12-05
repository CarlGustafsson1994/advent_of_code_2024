segments = File.readlines("./input.txt", chomp: true).join
start_and_end = segments.split(/do\(\)|don't\(\)/).values_at(0, -1)
middle_segments_scanned = segments.scan(/do\(\)(.*?)don't\(\)/)

[start_and_end, middle_segments_scanned].flatten.reduce(0) do |sum, segment|
  sum += segment.scan(/mul\((\d{1,3}),(\d{1,3})\)/).reduce(0) do |segment_sum, pair|
    segment_sum += pair[0].to_i * pair[1].to_i
    segment_sum
  end
  sum
end.tap { puts _1 }

reports = File.readlines("./input_02.txt").map { _1.scan(/\d+/).map(&:to_i) }
reports.inject(0) do |count, report|
  series = report.each_cons(2).map { _1 - _2 }
  count += 1 if series.none? { |n| n.zero? || n.abs > 3 } && (series.all?(&:negative?) || series.all?(&:positive?))
  count
end.tap { puts _1 }

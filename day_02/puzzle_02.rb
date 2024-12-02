require "byebug"

reports = File.readlines("./input_02.txt").map { _1.scan(/\d+/).map(&:to_i) }
reports.inject(0) do |count, report|
  series = report.each_cons(2).map { _1 - _2 }
  series_valid = series.none? { |n| n.zero? || n.abs > 3 } && (series.all?(&:negative?) || series.all?(&:positive?))
  step_count_dampened = series.map { _1.nonzero? && _1.abs < 4 }.tally[false].to_i < 2
  direction_dampened = [series.select(&:negative?), series.select(&:positive?)].map(&:count).all?(&:nonzero?) || series.select(&:zero?).count.nonzero?
  count += 1 if (series_valid || step_count_dampened || direction_dampened)
  count
end.tap { puts _1 }

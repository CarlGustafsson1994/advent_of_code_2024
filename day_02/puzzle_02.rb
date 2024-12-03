reports = File.readlines("./input_02.txt").map { _1.scan(/\d+/).map(&:to_i) }
reports.inject(0) do |count, report|
  dampened_series = report.map.with_index { |_, map_index| report.reject.with_index { |_, reject_index| reject_index == map_index } }
  dampened_series_safe = dampened_series.any? do |series|
    series_diffs = series.each_cons(2).map { _1 - _2 }
    series_diffs.none? { |n| n.abs > 3 } && (series_diffs.all?(&:negative?) || series_diffs.all?(&:positive?))
  end
  count += 1 if dampened_series_safe
  count
end.tap { puts _1 }

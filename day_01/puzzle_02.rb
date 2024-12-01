File.readlines("./input_01.txt")
    .map(&:split)
    .flatten
    .map(&:to_i)
    .partition.with_index { |_, index| index.even? }
    .tap { |g1, g2| tally = g2.tally; p g1.map { |id| (tally[id] || 0) * id }.sum }

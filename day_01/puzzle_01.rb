File.readlines("./input_01.txt")
    .map(&:split)
    .flatten
    .map(&:to_i)
    .partition.with_index { |_, index| index.even? }
    .map(&:sort)
    .tap { |g1, g2| p g1.zip(g2).map { |id_1, id_2| (id_1 - id_2).abs }.sum }

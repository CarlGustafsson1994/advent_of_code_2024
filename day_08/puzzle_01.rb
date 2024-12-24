grid = File.readlines("./input.txt", chomp: true).map(&:chars)
antennas = grid.flat_map { |row| row.reject { |char| char == "." } }.uniq

antenna_coordinates = ->(grid, antenna) do
  grid.each_with_index.with_object([]) do |(row, x), coordinates|
    row.each_with_index do |cell, y|
      coordinates << [x, y] if cell == antenna
    end
  end
end

sum_coords = ->(a, b) do
  a.zip(b).map(&:sum)
end

out_of_bounds = ->(grid, new_location) do
  new_location.any? { _1 < 0 || _1 > (grid.size - 1) }
end

antinodes = antennas.map do |antenna|
  coordinates = antenna_coordinates.call(grid, antenna)
  coordinate_combinations = coordinates.combination(2).to_a
  derivatives = coordinate_combinations.map do |(x1, y1), (x2, y2)|
    { start: [x1, y1], end: [x2, y2], derivative: [(x2 - x1), (y2 - y1)] }
  end
  derivative_paths = derivatives.map do |derivative|
    start_x, start_y = derivative[:end]
    path = [] << [start_x, start_y]
    dx, dy = derivative[:derivative]
    path << sum_coords.(path[-1], [dx, dy]) until out_of_bounds.(grid, sum_coords.call(path[-1], [dx, dy])) || path.length > 1
    start_x2, start_y2 = derivative[:start]
    path_reversed = [] << [start_x2, start_y2]
    path_reversed << sum_coords.(path_reversed[-1], [-dx, -dy]) until out_of_bounds.(grid, sum_coords.(path_reversed[-1], [-dx, -dy])) || path_reversed.length > 1
    (path[1..] + path_reversed[1..])
  end
end

puts "Antinodes: #{antinodes.flatten(2).uniq.count}"

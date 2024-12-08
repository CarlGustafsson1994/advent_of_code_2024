laboratory_grid = File.readlines("./input_06.txt", chomp: true).map(&:chars)
current_coordinate = nil
current_direction = nil
visited_coordinates = []
directions = [["^", [-1, 0]], [">", [0, 1]], ["v", [1, 0]], ["<", [0, -1]]]

laboratory_grid.each_with_index do |row, row_index|
  row.each_with_index do |cell, cell_index|
    if ["^", ">", "<", "v"].include?(cell)
      current_direction = cell
      visited_coordinates << current_coordinate = [row_index, cell_index]
      break
    end
  end
end

directions.rotate! until directions.first.first == current_direction
direction_map = directions.to_h
direction_loop = directions.to_h.cycle
until current_coordinate.any? { |co| co < 0 || co > laboratory_grid.length - 1 || co > laboratory_grid.first.length - 1 } do
  next_coordinate_in_current_direction = current_coordinate.zip(direction_map[current_direction]).map(&:sum)
  if laboratory_grid.at(next_coordinate_in_current_direction.first)&.at(next_coordinate_in_current_direction.last) == "#"
    current_direction = direction_loop.next.first
  else
    current_coordinate = next_coordinate_in_current_direction
    visited_coordinates << current_coordinate unless visited_coordinates.include?(current_coordinate)
  end
end
visited_coordinates.pop
puts visited_coordinates.length

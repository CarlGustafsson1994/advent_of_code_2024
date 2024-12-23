grid = File.readlines("./input.txt", chomp: true).map(&:chars)
guard_location = []
guard_location << grid[guard_location.push(grid.index { |row| row.include?("^") }).first].index("^")

directions = ["^", ">", "v", "<"]
direction_map = { "^" => [-1, 0], ">" => [0, 1], "v" => [1, 0], "<" => [0, -1] }
current_location = guard_location.dup

next_location = ->(current_location, direction) do
  x, y = current_location
  dx, dy = direction
  [x + dx, y + dy]
end

grid_copy = ->(grid) do
  grid.map { _1.map(&:dup) }
end

simulate_guard = ->(new_grid, current_location, direction_map, directions, next_location) do
  continue_loop = true
  direction_hash = {}
  infinite_loop = false

  while continue_loop
    new_x, new_y = next_location.call(current_location, direction_map[directions.peek])
    if [new_x, new_y].any? { |cord| cord < 0 || cord > (new_grid.size - 1) }
      continue_loop = false
    else
      directions.next if new_grid[new_x][new_y] == "#"
      new_x2, new_y2 = next_location.call(current_location, direction_map[directions.peek])
      directions.next if new_grid[new_x2][new_y2] == "#"
      current_location = next_location.call(current_location, direction_map[directions.peek])
      if direction_hash[current_location] == directions.peek
        continue_loop = false
        infinite_loop = true
      else
        direction_hash[current_location] = directions.peek
      end
      new_grid[current_location.first][current_location.last] = "X"
    end
  end
  infinite_loop
end

first_run_grid = grid_copy.call(grid)
first_run = simulate_guard.call(first_run_grid, current_location, direction_map, directions.cycle, next_location)

potential_obstacles = first_run_grid.each_with_index.with_object([]) do |(row, x), coordinates|
  row.each_with_index do |cell, y|
    coordinates << [x, y] if [x, y] != guard_location && cell == "X"
  end
end

time_loops = 0
potential_obstacles.each_with_index do |obstacle, index|
  new_grid = grid_copy.call(grid)
  new_grid[obstacle.first][obstacle.last] = "#"

  is_infinite = simulate_guard.call(new_grid, guard_location, direction_map, directions.cycle, next_location)
  time_loops += 1 if is_infinite
end

puts time_loops

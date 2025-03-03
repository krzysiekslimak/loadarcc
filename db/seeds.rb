Route.destroy_all
Load.destroy_all

routes = [
  { from: 'Berlin', to: 'Warsaw' },
  { from: 'Belfast', to: 'Cardiff' },
  { from: 'Prague', to: 'Brussels' },
  { from: 'Amsterdam', to: 'Cologne' }
]

routes.each do |route_data|
  route = Route.create!(route_data)
  puts "Created route: #{route.from} -> #{route.to}"
end

puts "Created #{Route.count} routes"

# Dodajemy Load-y z poprawnymi wartościami enum
Load.create!(load_type: 0)
Load.create!(load_type: 1)
Load.create!(load_type: 2)

puts "Created #{Load.count} load types"

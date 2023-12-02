-- Completed in 47m44s07 (original implementation used Disjktra)

local GRAPH, P1 = {}, 0
for line in io.lines() do
	local orbitee, orbiter = line:match("(%w+)%)(%w+)")

	GRAPH[orbiter] = GRAPH[orbiter] or {
		orbits = nil,
		orbited = {},
	}
	GRAPH[orbiter].orbits = orbitee

	GRAPH[orbitee] = GRAPH[orbitee] or {
		orbits = nil,
		orbited = {},
	}
	GRAPH[orbitee].orbited[orbiter] = true
end

for k in pairs(GRAPH) do
	local n = GRAPH[k].orbits
	while n do
		P1, n = P1 + 1, GRAPH[n].orbits
	end
end

-- BFS update all distances
local seen, q, dist = {}, { "YOU" }, { YOU = 0 }
while #q > 0 do
	local v = table.remove(q, 1)
	-- unvisited neighbours
	local n = GRAPH[v]
	if n.orbits then
		table.insert(q, n.orbits)
		seen[n.orbits], dist[n.orbits] = true, dist[v] + 1
	end
	for k in pairs(n.orbited) do
		if not seen[k] then
			table.insert(q, k)
			seen[k], dist[k] = true, dist[v] + 1
		end
	end
end
P2 = dist.SAN - 2
print(P1, P2)

-- Completed in 47m44s07

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

local function dijkstra(graph, source, target)
	local dist, q, qlen = {}, {}, 0
	for v in pairs(graph) do
		dist[v] = math.maxinteger
		qlen = qlen + 1
		q[v] = true
	end
	dist[source] = 0

	while qlen > 0 do
		-- unvisited node with minimum distance
		local u, mindist = nil, math.maxinteger
		for k in pairs(q) do -- no motivation for heap
			if dist[k] < mindist then
				u, mindist = k, dist[k]
			end
		end
		assert(u, "mindist node can't be nil")
		if u == target then
			return dist[u]
		end
		q[u], qlen = nil, qlen - 1

		-- unvisited neighbours
		local n = graph[u]
		local adjacent = { n.orbits }
		for k in pairs(n.orbited) do
			if q[k] then
				table.insert(adjacent, k)
			end
		end

		for _, k in ipairs(adjacent) do
			local alt = dist[u] + 1
			dist[k] = alt < dist[k] and alt or dist[k]
		end
	end
end

P2 = dijkstra(GRAPH, GRAPH.YOU.orbits, "SAN") - 1
print(P1, P2)

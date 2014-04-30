yo_cache.blade_runner = Ember.Object.extend(
	init: (ways, lower_line_limit = 8, upper_line_limit = 64, cache_size = 16 *1024, memory_size = 1024*1204) ->
		cache = require 'cache'
		generate = require 'memory_generator'
		
		i = lower_line_limit
		@data = {}
		@data[ways] = {}
		while i <= upper_line_limit
			@lord_of_the_generators = new generate()
			@lord_of_the_caches = new cache(ways, i, cache_size, memory_size)
			@hits = 0
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.random_generation())
			@lord_of_the_caches = new cache(ways, i, cache_size, memory_size)
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.sequential_generation())
			@lord_of_the_caches = new cache(ways, i, cache_size, memory_size)
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.fruity_loops())
			@lord_of_the_caches = new cache(ways, i, cache_size, memory_size)
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.maple_loops())
			@data[ways][i] = @hits / (4*1000000)
			i = i * 2
		return @data
);
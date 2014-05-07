yo_cache.blade_runner = Ember.Object.extend(
	
	lower_line_limit: 8

	upper_line_limit: 64

	cache_size: 16 * 1024

	memory_size: 1024 * 1024
	
	init: ->
		i = @get('lower_line_limit')
		@data = {}
		@data[@get('ways')] = {}
		while i <= @get('upper_line_limit')
			@lord_of_the_generators = yo_cache.memory_generator.create()
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.random_generation())
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.sequential_generation())
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.fruity_loops())
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			for j in [0..1000000-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.maple_loops())
			@data[@get('ways')][i] = @hits / (4*1000000)
			i = i * 2
		return @data
)

yo_cache.blade_runner = Ember.Object.extend(
	init: ->
		i = @get('lower_line_limit')
		@data = {}
		@data[@get('name')] = {}
		@data['properties'] = {}
		@data['properties']['ways'] = @get('ways')
		@data['properties']['cache-size'] = @get('cache_size')
		@data['properties']['memory-size'] = @get('memory_size')
		@data[@get('name')]['random-generation'] = {}
		@data[@get('name')]['sequential-generation'] = {}
		@data[@get('name')]['fruity-loops'] = {}
		@data[@get('name')]['maple-loops'] = {}
		while i <= @get('upper_line_limit')
			@lord_of_the_generators = yo_cache.memory_generator.create()
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.random_generation())
			@data[@get('name')]['random-generation'][i] = @hits/@get('iterations')
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.sequential_generation())
			@data[@get('name')]['sequential-generation'][i] = @hits/@get('iterations')
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.fruity_loops())
			@data[@get('name')]['fruity-loops'][i] = @hits/@get('iterations')
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.maple_loops())
			@data[@get('name')]['maple-loops'][i] = @hits/@get('iterations')
			i = i * 2
		return @data

	lower_line_limit: 8

	upper_line_limit: 64

	cache_size: 16 * 1024

	memory_size: 1024 * 1024

	iterations: 1000000
	
	name: 'the_unamed_cache'
)

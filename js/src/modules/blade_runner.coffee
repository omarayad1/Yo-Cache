yo_cache.blade_runner = Ember.Object.extend(
	init: ->
		i = @get('lower_line_limit')
		@data = []
		@data[0] = {'key': @get('name') + '-random-generation'}
		@data[1] = {'key': @get('name') + '-sequential-generation'}
		@data[2] = {'key': @get('name') + '-fruity-loops'}
		@data[3] = {'key': @get('name') + '-maple-loops'}
		@data[0]['values'] = []
		@data[1]['values'] = []
		@data[2]['values'] = []
		@data[3]['values'] = []
		while i <= @get('upper_line_limit')
			@lord_of_the_generators = yo_cache.memory_generator.create()
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.random_generation())
			@data[0]['values'].push([i,@hits/@get('iterations')])
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.sequential_generation())
			@data[1]['values'].push([i,@hits/@get('iterations')])
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.fruity_loops())
			@data[2]['values'].push([i,@hits/@get('iterations')])
			@lord_of_the_caches = yo_cache.cache.create({ways: @get('ways'), line_size: i, cache_size: @get('cache_size'), memory_size: @get('memory_size')})
			@hits = 0
			for j in [0..@get('iterations')-1] by 1
				@hits += @lord_of_the_caches.read(@lord_of_the_generators.maple_loops())
			@data[3]['values'].push([i,@hits/@get('iterations')])
			i = i * 2
		return @data

	lower_line_limit: 8

	upper_line_limit: 64

	cache_size: 16 * 1024

	memory_size: 1024 * 1024

	iterations: 1000000
	
	name: 'the_unamed_cache'
)

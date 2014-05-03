yo_cache.memory_generator = Ember.Object.extend(
	init: ->
		@address_sequential = -1
		@address_fruity = -1
		@address_maple = -1
	random_generation: ->
		@instruction = Math.floor (Math.random() * (1024 * 1024))
		@instruction
	sequential_generation: ->
		@address_sequential += 1
		(@address_sequential) % (1024 * 1024)
	fruity_loops: ->
		@address_fruity += 1
		(@address_fruity) % (1024 * 4)
	maple_loops: ->
		@address_maple += 1
		(@address_maple) % (1024 * 24)
)

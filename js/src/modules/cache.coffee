yo_cache.cache = Ember.Object.extend(
	memory: Ember.Object.extend().create()
	init: ->
		@ways
		@line_size
		@cache_size
		@memory_size
		@index = if !@ways then 1 else @cache_size / (@ways * @line_size)
		@index_bit_size = if !@ways then 0 else Math.log(@index) / Math.LN2
		@ways = if !@ways then @cache_size / @line_size else @ways
		@address_bit_size = Math.log(@memory_size) / Math.LN2
		@offset_bit_size = Math.log(@line_size) / Math.LN2
		@tag_bit_size = @address_bit_size - @index_bit_size - @offset_bit_size
		i = 0
		j = 0
		for i in [0..@index-1] by 1
			@memory.set(i.toString(), Ember.Object.extend().create())
			for j in [0..@ways-1] by 1
				@memory[i.toString()].set(j.toString(), null)
	read: (address) ->
		index = 0
		if @index_bit_size != 0
			index = address >>> @offset_bit_size
			index = index << (32 - @index_bit_size)
			index = index >>> (32 - @index_bit_size)
		tag = address >>> (@index_bit_size + @offset_bit_size)
		i = 0
		empty = null
		for i in [0..@ways-1] by 1
			if @memory[index][i] is null
				empty = i
			else if @memory[index][i] == tag
				return true
		if empty != null
			@memory[index][empty] = tag
			return false
		else if empty is null
			random_slot = Math.floor(Math.random()*(@ways-1))
			@memory[index][random_slot] = tag
			return false
)

#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
##
## Cache Class
##
## 1. Generates a cache structure based on the number
## of ways and the line size
##
## 2. Generates a Hit or Miss given a data address based
## on the read method implemented in the class
## Yeah Bitch!, Thats our "method" *rimshot*
## 
## Functions implemented from "casheModels.js" *
## this is merely a class implementaion
##
## * not to be mistaken with sexy cash models
##
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################
#################################################################

class cache
	constructor: (ways, line_size, cache_size = 16 * 1024, memory_size = 1024 * 1024) ->
		@ways = ways
		@line_size = line_size
		@cache_size = cache_size
		@memory_size = memory_size
		@index = if !@ways then 1 else @cache_size / (@ways * @line_size)
		@ways = if !@ways then @cache_size / @line_size else @ways
		@address_bit_size = Math.log(@memory_size) / Math.LN2
		@offset_bit_size = Math.log(@line_size) / Math.LN2
		@index_bit_size = Math.log(@index) / Math.LN2
		@tag_bit_size = @address_bit_size - @index_bit_size - @offset_bit_size
		i = 0
		j = 0
		while i<@index
			@memory[i] = {}
			while j < @ways
				@memory[i][j] = null
				j += 1
			i += 1
	read: (address) ->
		index = address >>> @offset_bit_size
		index = index << @tag_bit_size
		index = index >>> @tag_bit_size
		tag = address >>> (@index_bit_size + @offset_bit_size)
		i = 0
		empty = null;
		while i < @ways
			if @memory[index][i] is null
				empty = i
		for i in [0..@ways-1] by 1
			if @memory[index][i] == tag
				return true
		if empty is not null
			@memory[index][empty] = tag
			return false
		else if empty is null
			random_slot = Math.floor(Math.random()*(@ways-1))
			@memory[index][random_slot]
			return false
		else
			return false
module.exports = cache

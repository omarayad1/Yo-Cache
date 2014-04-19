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
## on some methods implemented in the class
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
		@address_bit_size = Math.log(@memory_address_space) / Math.LN2
		@offset_bit_size = (Math.log(@line_size) / Math.LN2)
		if !@ways
			@index_bit_size = 0
		else if @ways == 1
			@index_bit_size = (Math.log(@cache_size) / Math.LN2) - @offset_bit_size
		else
			@index_bit_size = (Math.log(@cache_size) / Math.LN2) - ((Math.log(@ways) / Math.LN2) + (Math.log(@line_size) / Math.LN2))
		@tag_bit_size = @address_bit_size - @index_bit_size - @offset_bit_size
		@memeory = NULL
	read: (address) -> #This method has a buttload of mistakes fix it!
		offset = address % @line_size
		index = (address / @line_size) % @index_bit_size
		tag = (address / (@index_bit_size * offset))
		if @memeory.index.tag.offset is null
			@memeory.index.tag.offset = address
			return false
		else
			return true
module.exports = cache

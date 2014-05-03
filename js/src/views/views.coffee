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
## Ember Views
## The nuts and bolts of the application view
## controls plugins load and button events
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

yo_cache.options_view = Ember.View.extend(
	templateName: "simulation-options"
	)
yo_cache.range_slider_view = Ember.View.extend(
	template: Ember.Handlebars.compile("{{input type='text' class='line-size-range'}}")
	didInsertElement: -> 
		$('.line-size-range').ionRangeSlider(
				min: 8,
				max: 512,
				type: 'double',
				step: 32
		)
	)

yo_cache.cache_properties_view = Ember.View.extend(
	templateName: 'cache-properties'
	classNames: ['cache-property']
	didInsertElement: ->
		dat_element = this
		dat_element.$().find('.select-block').selectpicker()
		dat_element.$().find('.select-block').on('change', ->
			value = dat_element.$().find(':selected').text()
			if (value == "Other")
				dat_element.$().find('.other-cache-type').removeAttr('disabled')
			else
				dat_element.$().find('.other-cache-type').attr('disabled','disabled')
		)
	)

yo_cache.cache_adder_button = Ember.View.extend(
	tagName: 'div'
	classNames: ['btn', 'btn-inverse', 'btn-lg']
	template: Ember.Handlebars.compile('Add Another Cache')
	attributeBindings: ['href']
	href: '#'
	click: ->
		yo_cache.cache_properties_view.create().appendTo('.lord-of-the-caches')
	)

yo_cache.cache_simulator_button = Ember.View.extend(
	tagName: 'a'
	classNames: ['btn', 'btn-danger', 'btn-lg']
	attributeBindings: ['href']
	href: './index.html#/simulation'
	template: Ember.Handlebars.compile('Simulate')
	click: ->
		$('.cache-property').each (data) ->
			dat = this
			cache_name = $(dat).find('.cache-name').val()
			memory_size = $(dat).find('.memory-size').val()
			cache_size = $(dat).find('.cache-size').val()
			ways = if $(dat).find('.select-block').find(':selected').text() == 'Other' \
				then $(dat).find('.other-cache-type').val() \
				else $(dat).find('.select-block').find(':selected').val()
	)

Ember.Handlebars.helper 'range-slider', yo_cache.range_slider_view
Ember.Handlebars.helper 'cache-properties', yo_cache.cache_properties_view
Ember.Handlebars.helper 'cache-adder', yo_cache.cache_adder_button
Ember.Handlebars.helper 'cache-simulator-button', yo_cache.cache_simulator_button

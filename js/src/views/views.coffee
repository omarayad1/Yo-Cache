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

fs = require 'fs'

yo_cache.options_view = Ember.View.extend
	templateName: "simulation-options"

yo_cache.range_slider_view = Ember.View.extend
	template: Ember.Handlebars.compile "{{input type='text' class='line-size-range'}}"
	didInsertElement: -> 
		$('.line-size-range').ionRangeSlider
				min: 8,
				max: 512,
				type: 'double',
				step: 32

yo_cache.cache_properties_view = Ember.View.extend
	templateName: 'cache-properties'
	classNames: ['cache-property']
	didInsertElement: ->
		dat_element = this
		dat_element.$().find('.select-block').selectpicker()
		dat_element.$().find('.select-block').on 'change', ->
			value = dat_element.$().find(':selected').text()
			if (value == "Other")
				dat_element.$().find('.other-cache-type').removeAttr('disabled')
			else
				dat_element.$().find('.other-cache-type').attr('disabled','disabled')

yo_cache.cache_adder_button = Ember.View.extend
	tagName: 'div'
	classNames: ['btn', 'btn-inverse', 'btn-lg']
	template: Ember.Handlebars.compile('Add Another Cache')
	attributeBindings: ['href']
	href: '#'
	click: ->
		yo_cache.cache_properties_view.create().appendTo('.lord-of-the-caches')

yo_cache.cache_simulator_button = Ember.View.extend
	tagName: 'a'
	classNames: ['btn', 'btn-danger', 'btn-lg']
	attributeBindings: ['href']
	href: './index.html#/simulation'
	template: Ember.Handlebars.compile('Simulate')
	click: ->
		lower_line_limit = $('.irs-from').text()
		upper_line_limit = $('.irs-to').text()
		yo_cache.simulationdata = []
		$('.cache-property').each (data) ->
			dat = this
			cache_name = $(dat).find('.cache-name').val()
			memory_size = $(dat).find('.memory-size').val()
			cache_size = $(dat).find('.cache-size').val()
			iterations = $(dat).find('.iterations').val()
			ways = if $(dat).find('.select-block').find(':selected').text() == 'Other' \
				then $(dat).find('.other-cache-type').val() \
				else $(dat).find('.select-block').find(':selected').val()
			results = yo_cache.blade_runner.create(
				name: cache_name
				ways: parseInt(ways)
				lower_line_limit: parseInt(lower_line_limit)
				upper_line_limit: parseInt(upper_line_limit)
				cache_size: eval(cache_size)
				memory_size: eval(memory_size)
				iterations: parseInt(iterations)
			)
			yo_cache.simulationdata = yo_cache.simulationdata.concat(results.data)
		fs.writeFileSync('/home/omarayad1/Documents/git/Yo-Cache/data.json', JSON.stringify(yo_cache.simulationdata))

yo_cache.cache_graph_view = Ember.View.extend
	classNames: ['graph']
	template: Ember.Handlebars.compile("<div id='chart' style='width:100%'><svg style='height:500px' />")
	didInsertElement: ->
		d3.json "data.json", (data) ->
		  nv.addGraph ->
		    chart = nv.models.stackedAreaChart().margin(right: 100).x((d) ->
		      d[0]
		    ).y((d) ->
		      d[1]
		    ).useInteractiveGuideline(true)\
		    .rightAlignYAxis(true)\
		    .transitionDuration(500)\
		    .showControls(true)\
		    .clipEdge(true)
		    chart.xAxis.tickFormat d3.format(",.0f")
		    chart.yAxis.tickFormat d3.format(",.6f")
		    d3.select("#chart svg").datum(data).call chart
		    nv.utils.windowResize chart.update
		    chart

yo_cache.app_exit = Ember.View.extend
	tagName: 'a'
	classNames: ['btn', 'btn-danger', 'btn-lg', 'exit-button']
	template: Ember.Handlebars.compile('Exit')
	click: ->
		gui = require 'nw.gui'
		gui.App.quit()

Ember.Handlebars.helper 'range-slider', yo_cache.range_slider_view
Ember.Handlebars.helper 'cache-properties', yo_cache.cache_properties_view
Ember.Handlebars.helper 'cache-adder', yo_cache.cache_adder_button
Ember.Handlebars.helper 'cache-simulator-button', yo_cache.cache_simulator_button
Ember.Handlebars.helper 'graph-results', yo_cache.cache_graph_view
Ember.Handlebars.helper 'exit-button', yo_cache.app_exit

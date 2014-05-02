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
	get_max: -> 
		$('.irs-to').text()
)
yo_cache.cache_properties_view = Ember.View.extend(
	templateName: 'cache-properties'
	didInsertElement: ->
		dat_element = this
		dat_element.$().find('.select-block').selectpicker()
		dat_element.$().find('.select-block').on('change', ->
			value = dat_element.$().children(':selected').text();
			if (value == "Other") dat_element.$().find('.other-cache-type').removeAttr('disabled');
			else dat_element.$().find('.other-cache-type').attr('disabled','disabled');
		)
	##	cache property view
)

yo_cache.cache_properties_collection = Ember.CollectionView.extend()

Ember.Handlebars.helper 'range-slider', yo_cache.range_slider_view
Ember.Handlebars.helper 'omak', yo_cache.cache_properties_view

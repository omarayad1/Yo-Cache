yo_cache.Router.map ->
  @resource 'start'
  @resource 'simulation-options'
  @resource 'simulation'

yo_cache.start_route = Ember.Route.extend()
yo_cache.settings_route = Ember.Route.extend()
yo_cache.simulation_route = Ember.Route.extend()
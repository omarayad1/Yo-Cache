(function() {
  window.yo_cache = Ember.Application.create();

  yo_cache.Router.map(function() {
    this.route('start', {
      path: '/'
    });
    return this.route('simulation-options', {
      path: '/settings'
    });
  });

}).call(this);

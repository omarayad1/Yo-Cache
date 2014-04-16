(function() {
  var fs;

  fs = require('fs');

  window.yo_cache = Ember.Application.create();

  yo_cache.Router.map(function() {
    return this.resource('start', {
      path: '/'
    });
  });

}).call(this);

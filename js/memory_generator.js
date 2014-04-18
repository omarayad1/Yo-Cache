(function() {
  var memory_generator;

  memory_generator = (function() {
    memory_generator.prototype.random_generation = function() {
      var address;
      address = Math.floor(Math.random() * 1024 * 1024);
      return address;
    };

    memory_generator.prototype.sequential_generation = function() {
      var address;
      if (typeof address === void 0) {
        address = 0;
      }
      return (address++) % (1024 * 1024);
    };

    memory_generator.prototype.fruity_loops = function() {
      var address;
      if (typeof address === void 0) {
        address = 0;
      }
      return (address++) % (1024 * 4);
    };

    memory_generator.prototype.maple_loops = function() {
      var address;
      if (typeof address === void 0) {
        address = 0;
      }
      return (address++) % (1024 * 24);
    };

    function memory_generator(generation_type) {
      this.generation_type = generation_type;
      this.generation_types = {
        1: this.random_generation,
        2: this.sequential_generation,
        3: this.fruity_loops,
        4: this.maple_loops
      };
      this.generation_types[this.generation_type];
    }

    return memory_generator;

  })();

  modules.exports = memory_generator;

}).call(this);

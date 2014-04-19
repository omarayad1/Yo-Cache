(function() {
  var memory_generator;

  memory_generator = (function() {
    function memory_generator() {
      this.address_sequential = -1;
      this.address_fruity = -1;
      this.address_maple = -1;
    }

    memory_generator.prototype.random_generation = function() {
      this.instruction = Math.floor(Math.random() * (1024 * 1024));
      return this.instruction;
    };

    memory_generator.prototype.sequential_generation = function() {
      this.address_sequential += 1;
      return this.address_sequential % (1024 * 1024);
    };

    memory_generator.prototype.fruity_loops = function() {
      this.address_fruity += 1;
      return this.address_fruity % (1024 * 4);
    };

    memory_generator.prototype.maple_loops = function() {
      this.address_maple += 1;
      return this.address_maple % (1024 * 24);
    };

    return memory_generator;

  })();

  module.exports = memory_generator;

}).call(this);

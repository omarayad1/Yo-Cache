(function() {
  var cache;

  cache = (function() {
    function cache(ways, line_size, cache_size, memory_size) {
      var i, j;
      if (cache_size == null) {
        cache_size = 16 * 1024;
      }
      if (memory_size == null) {
        memory_size = 1024 * 1024;
      }
      this.ways = ways;
      this.line_size = line_size;
      this.cache_size = cache_size;
      this.memory_size = memory_size;
      this.index = !this.ways ? 1 : this.cache_size / (this.ways * this.line_size);
      this.ways = !this.ways ? this.cache_size / this.line_size : this.ways;
      this.address_bit_size = Math.log(this.memory_size) / Math.LN2;
      this.offset_bit_size = Math.log(this.line_size) / Math.LN2;
      this.index_bit_size = Math.log(this.index) / Math.LN2;
      this.tag_bit_size = this.address_bit_size - this.index_bit_size - this.offset_bit_size;
      i = 0;
      j = 0;
      while (i < this.index) {
        this.memory[i] = {};
        while (j < this.ways) {
          this.memory[i][j] = null;
          j += 1;
        }
        i += 1;
      }
    }

    cache.prototype.read = function(address) {
      var empty, i, index, random_slot, tag, _i, _ref;
      index = address >>> this.offset_bit_size;
      index = index << this.tag_bit_size;
      index = index >>> this.tag_bit_size;
      tag = address >>> (this.index_bit_size + this.offset_bit_size);
      i = 0;
      empty = null;
      while (i < this.ways) {
        if (this.memory[index][i] === null) {
          empty = i;
        }
      }
      for (i = _i = 0, _ref = this.ways - 1; _i <= _ref; i = _i += 1) {
        if (this.memory[index][i] === tag) {
          return true;
        }
      }
      if (empty === !null) {
        this.memory[index][empty] = tag;
        return false;
      } else if (empty === null) {
        random_slot = Math.floor(Math.random() * (this.ways - 1));
        this.memory[index][random_slot];
        return false;
      } else {
        return false;
      }
    };

    return cache;

  })();

  module.exports = cache;

}).call(this);

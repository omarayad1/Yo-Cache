(function() {
  var cache;

  cache = (function() {
    function cache(ways, line_size, cache_size, memory_size) {
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
      this.address_bit_size = Math.log(this.memory_address_space) / Math.LN2;
      this.offset_bit_size = Math.log(this.line_size) / Math.LN2;
      if (!this.ways) {
        this.index_bit_size = 0;
      } else if (this.ways === 1) {
        this.index_bit_size = (Math.log(this.cache_size) / Math.LN2) - this.offset_bit_size;
      } else {
        this.index_bit_size = (Math.log(this.cache_size) / Math.LN2) - ((Math.log(this.ways) / Math.LN2) + (Math.log(this.line_size) / Math.LN2));
      }
      this.tag_bit_size = this.address_bit_size - this.index_bit_size - this.offset_bit_size;
      this.memeory = NULL;
    }

    cache.prototype.read = function(address) {
      var index, offset, tag;
      offset = address % this.line_size;
      index = (address / this.line_size) % this.index_bit_size;
      tag = address / (this.index_bit_size * offset);
      if (this.memeory.index.tag.offset === null) {
        this.memeory.index.tag.offset = address;
        return false;
      } else {
        return true;
      }
    };

    return cache;

  })();

  module.exports = cache;

}).call(this);

// The following is the memory address generator class.
function memGenerator(method) {

	// This selects the method to be called. 
	this.generate = function (method) {
		switch (method) {
			case "R":
				return this.rand();
				break;
			case "S":
				return this.sequence();
				break;
			case "L1":
				return this.loop1();
				break;
			case "L2":
				return this.loop2();
				break;
		}
	};

	// This generates a random sequence of addresses.
	this.rand = function() {
		return Math.floor((Math.random() * 1024 * 1024));
	};

	// This generates sequential addresses.
	this.sequence = function() {
		if (typeof this.address === 'undefined')
			this.address = 0;
		return (this.address++) % (1024*1024);
	};

	// This generates addresses in a small loop.
	this.loop1 = function() {
		if (typeof this.address === 'undefined')
			this.address = 0;
		return (this.address++) % (1024*4);
	};

	//This generates addresses in a big loop.
	this.loop2 = function() {
		if (typeof this.address === 'undefined')
			this.address = 0;
		return (this.address++) % (1024*24);
	};

}

// The following is the cache simulator class.
function cacheSim(ways,lineSize) {
	lineSize = typeof lineSize !== 'undefined' ? lineSize : 16;
	var row, column;
	var index;
	// Addjusting the dimensions of the cache according the number of ways.
	switch (ways) {
		// Direct-mapped Cache.
		case 1:{
			row = 16384/lineSize;
			column = 1;
			index = row;
			break;
		}
		// 2-way Set-Associative Cache.
		case 2:{
			row = 8192;
			column = 2;
			index = row;
			break;
		}
		// 4-way Set-Associative Cache.
		case 4:{
			row = 4096;
			column = 4;
			index = row;
			break;
		}
		// 8-way Set-Associative Cache.
		case 8:{
			row = 2048;
			column = 8;
			index = row;
			break;
		}
		// Fully Associative Cache.
		default:{
			row = 1;
			column = 16384/lineSize;
			index = 1;
			break;
		}
	}
	// Creating a cache with the correct dimensions.
	this.cache = new Array(row);
	for (var i=0; i<row; i++) {
		this.cache[i] = new Array(column);
	}
	// Setting up an empty cache.
	this.initial = function() {
		for (var i=0; i<row; i++) {
			for (var j=0; j<column; j++) {
				this.cache[i][j] = -1;
			}
		}
	};
	this.hitOrMiss = function(address) {
		var offset = address%lineSize;
		var lineNum = (address/lineSize)%index;
		var tag = (address/(index*offset));
		for (var j=0; j<column; j++) {
			if (this.cache[index][j] === tag)
				return true;
			else {
				this.cache[index][j] = tag;
				return false;
			}
		}
	};
}
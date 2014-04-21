// The following is the memory address generator class.
function memGenerator() {

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
		if (typeof this.address === "undefined")
			this.address = 0;
		return (this.address++) % (1024*1024);
	};

	// This generates addresses in a small loop.
	this.loop1 = function() {
		if (typeof this.address === "undefined")
			this.address = 0;
		return (this.address++) % (1024*4);
	};

	//This generates addresses in a big loop.
	this.loop2 = function() {
		if (typeof this.address === "undefined")
			this.address = 0;
		return (this.address++) % (1024*24);
	};

}

// The following is the cache simulator class.
function cacheSim(ways,lineSize) {
	lineSize = typeof lineSize !== "undefined" ? lineSize : 16;
	var row, column;
	var index;
	// Addjusting the dimensions of the cache according the number of ways.
	/**
	 * Bazinga!!! something Wrong here, row is equal to size/(ways*line_size)
	 */
	switch (ways) {
		// Direct-mapped Cache.
		case 1:{
			row = 16384/lineSize;
			 /**
			  * number of ways
			  * @type {Number}
			  */
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
			index = 1; // Check this for corrections.
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
		// The lineNum is the index part of the address.
		// Bazinga another mistake better use shifting here
		var lineNum = parseInt(address/lineSize);
		lineNum = lineNum%index;
		var tag = (address/(index*lineSize)); // The tag is the address after truncating the offset (lineSize) and the index.
		tag = parseInt(tag);
		var empty = -1; // This is used to store the location of any empty location in the cache.
		for (var j=0; j<column; j++) {
			// If a cache line is empty store its location in empty.
			
			if (this.cache[lineNum][j] === -1)
				empty = j;
			// If a match is found return true.
			if (this.cache[lineNum][j] === tag)
				return true;
			// If there is no match, check if there is an empty location to write to, else use the random replacement policy.
			else if (j === column-1) {
				if (empty !== -1)
					this.cache[lineNum][empty] = tag;
				else
					// Classic Bazinga!!! Math.floor(random()*(column - 1))
					this.cache[lineNum][Math.floor(random()*column)] = tag;
				return false;
			}
		}
	};
}

// Just for testing. IGNORE!
var x = new memGenerator();
var address = x.generate("R");

var y = new cacheSim (2);
y.initial();
for (var i=0; i<100; i++){
	console.log(y.hitOrMiss(i));
}
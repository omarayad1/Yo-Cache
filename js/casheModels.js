// The following is the memory address generator class.
// deprecate this implemented another class
/*function memGenerator(method) {

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

}*/
var memory_generator = require('memory_generator');
// The following is the cashe simulator class.
function casheSim(ways,lineSize) {
	lineSize = typeof lineSize !== 'undefined' ? lineSize : 16;
	var row, column;
	// Addjusting the dimensions of the cashe according the number of ways.
	switch (ways) {
		// Direct-mapped Cashe.
		case 1:{
			row = 16384/lineSize;
			column = 1;
			break;
		}
		// 2-way Set-Associative Cashe.
		case 2:{
			row = 8192;
			column = 2;
			break;
		}
		// 4-way Set-Associative Cashe.
		case 4:{
			row = 4096;
			column = 4;
			break;
		}
		// 8-way Set-Associative Cashe.
		case 8:{
			row = 2048;
			column = 8;
			break;
		}
		// Fully Associative Cashe.
		default:{
			row = 1;
			column = 16384/lineSize;
			break;
		}
	}
	// Creating a cashe with the correct dimensions.
	this.cashe = new Array(row);
	for (var i=0; i<row; i++) {
		this.cashe[i] = new Array(column);
		for (var j=0; j<column; j++) {
			this.cashe[i][j] = new Array(lineSize);
		}
	}
	// Setting up an empty cashe.
	this.initial = function() {
		for (var i=0; i<row; i++) {
			for (var j=0; j<column; j++) {
				for (var k=0; k<lineSize; k++) {
					this.cashe[i][j][k] = -1;
				}
			}
		}
	};
	this.hitOrMiss = function(address) {
		var number = (address/lineSize) % index;
	};
}

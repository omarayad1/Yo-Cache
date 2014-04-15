module.exports = function(grunt) {
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-sass');
	
	grunt.registerTask('default', ['coffee', 'sass'])
	grunt.initConfig({
		coffee: {
			compile: {
				files: {
					'js/app.js': 'js/src/app.coffee'
				}
			}
		},
		sass: {
			dist: {
				files: [{
					expand: true,
					cwd: '.',
					src: ['css/src/*.scss'],
					dest: '.',
					ext: '.css'
				}]
			}
		}
	});
};
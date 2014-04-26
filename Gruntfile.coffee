module.exports = (grunt) ->
  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-contrib-sass"
  grunt.loadNpmTasks "grunt-node-webkit-builder"
  grunt.registerTask "default", [
    "coffee"
    "sass"
  ]
  grunt.initConfig
    coffee:
      compile:
        files:
          "js/app.js": "js/src/app.coffee"
          "node_modules/memory_generator.js": "js/src/memory_generator.coffee"
          "node_modules/cache.js": "js/src/cache.coffee"
          "node_modules/blade_runner.js": "js/src/blade_runner.coffee"
          "js/views/range-slider.js": "js/src/views/range-slider.coffee"

    sass:
      dist:
        files: [
          expand: true
          cwd: "."
          src: ["css/src/*.scss"]
          dest: "."
          ext: ".css"
        ]

    nodewebkit:
      options:
        build_dir: "./webkitbuilds"
        mac: false
        win: false
        linux32: false
        linux64: true

      src: ["./**/**"]

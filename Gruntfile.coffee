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
          "js/views/range-slider.js": "js/src/views/range-slider.coffee"
          "js/modules/cache.js":"js/src/modules/cache.coffee"
          "js/modules/memory_generator.js":"js/src/modules/memory_generator.coffee"
          "js/modules/blade_runner.js":"js/src/modules/blade_runner.coffee"
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

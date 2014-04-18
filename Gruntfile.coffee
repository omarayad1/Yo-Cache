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
        build_dir: "./webkitbuilds" # Where the build version of my node-webkit app is saved
        mac: false # We want to build it for mac
        win: false # We want to build it for win
        linux32: false # We don't need linux32
        linux64: true # We don't need linux64

      src: ["./**/**"] # Your node-webkit app
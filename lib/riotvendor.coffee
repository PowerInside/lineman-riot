fs = require 'fs'
path = require 'path'
findsRoot = require 'find-root-package'
http = require 'https'
mkdirp = require 'mkdirp'

module.exports =
  inject: (dir = process.cwd()) ->
    topDir = findsRoot.findTopPackageJson dir
    riotTagDir = path.join topDir,'app/riottags'
    mkdirp riotTagDir
    mkdirp path.join topDir, 'vendor/js'
    dest = path.join topDir, 'vendor/js/riot.js'
    file = fs.createWriteStream dest
    request = http
      .get "https://raw.githubusercontent.com/muut/riotjs/master/riot.min.js",
      (response) ->
       response.pipe file
       console.log "Downloading latest riot.js to '#{dest}'"
       return

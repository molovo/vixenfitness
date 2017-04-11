# Base gulp dependencies
gulp         = require 'gulp'
source       = require 'vinyl-source-stream'
buffer       = require 'vinyl-buffer'
gutil        = require 'gulp-util'
rename       = require 'gulp-rename'
browserSync  = require 'browser-sync'

# Dependencies for compiling coffeescript
uglify       = require 'gulp-uglify'
sourcemaps   = require 'gulp-sourcemaps'
browserify   = require 'browserify'
watchify     = require 'watchify'
coffeelint   = require 'gulp-coffeelint'

# Dependencies for compiling sass
sassLint     = require 'gulp-sass-lint'
sass         = require 'gulp-sass'
autoprefixer = require 'gulp-autoprefixer'

# Dependencies for compressing images
imagemin     = require 'gulp-imagemin'

# Sources and entry points for compilation
sources =
  sass: 'assets/css/**/*.s+(a|c)ss'
  coffee: 'assets/js/**/*.coffee'
  images: 'assets/img/**/*'
  views: '**/*.html'
entries =
  sass: 'assets/css/main.sass'
  coffee: 'assets/js/main.coffee'

###*
 * The default task. Lints and compiles sass and coffeescript
###
gulp.task 'default', ['lint', 'compile']

###*
 * Linting tasks
###
gulp.task 'lint', ['lint:sass', 'lint:coffee']

gulp.task 'lint:sass', () ->
  gulp.src sources.sass
    .pipe sassLint()
    .pipe sassLint.format()
    .pipe sassLint.failOnError()

gulp.task 'lint:coffee', () ->
  gulp.src sources.coffee
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffeelint.reporter('fail')

###*
 * Compilation tasks
###
gulp.task 'compile', ['compile:sass', 'compile:coffee']

gulp.task 'compile:sass', () ->
  gulp.src entries.sass
    .pipe sass().on('error', sass.logError)
    .pipe autoprefixer(
      browsers: ['last 3 versions']
      cascade: false
    )
    .pipe rename('main.css')
    .pipe gulp.dest('css/')

gulp.task 'compile:coffee', () ->
  # Set up the browserify instance
  bundler = browserify(
    transform: ['coffeeify']
    debug: true
  )
  bundler.add entries.coffee

  # Compile the source
  bundler.bundle()
    .on 'error', gutil.log
    .pipe source('main.js')
    .pipe buffer()
    .pipe sourcemaps.init(loadMaps: true)
    .pipe rename('main.min.js')
    .pipe sourcemaps.write('./')
    .pipe gulp.dest('js/')

gulp.task 'images', () ->
  gulp.src sources.images
    .pipe imagemin([
      imagemin.gifsicle interlaced: true
      imagemin.jpegtran progressive: true
      imagemin.optipng optimizationLevel: 5
      imagemin.svgo plugins: [removeViewBox: true]
    ])
    .pipe gulp.dest('img/')

gulp.task 'serve', () ->
  browserSync.init(
    proxy: '127.0.0.1:4000'
  )

  gulp.watch 'css/**/*'
    .on 'change', browserSync.reload
  gulp.watch 'js/**/*'
    .on 'change', browserSync.reload
  gulp.watch sources.views
    .on 'change', browserSync.reload
  gulp.watch sources.images, ['images']
  gulp.watch sources.coffee, ['compile:coffee']
  gulp.watch sources.sass, ['compile:sass']

module.exports = {
  plugins: [
    require('flowbite/plugin')
],
  content: [
    "./node_modules/flowbite/**/*.js",
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}

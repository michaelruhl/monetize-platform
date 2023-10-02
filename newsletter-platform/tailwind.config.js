module.exports = {
  plugins: [
    require('flowbite/plugin'),
    require('@tailwindcss/forms'),
],
  content: [
    "./node_modules/flowbite/**/*.js",
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ]
}

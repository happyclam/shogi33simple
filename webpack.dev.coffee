module.exports =
  context: __dirname + ''
  entry: coffee: './gameGui.coffee'
  output:
    path: __dirname + ''
    filename: './shogi33.js'
  devtool: 'cheap-source-map'
  module: rules: [
    {
      test: /\.coffee$/
      exclude: /node_modules/
      loader: 'babel-loader!coffee-loader'
    }
  ]
  resolve: extensions: [
    '.js'
    '.json'
    '.coffee'
  ]

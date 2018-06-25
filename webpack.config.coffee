module.exports =
  context: __dirname + ''
  entry: coffee: './gameGui.coffee'
  output:
    path: __dirname + ''
    filename: './shogi33.js'
  devtool: 'cheap-source-map'
  module: loaders: [
    {
      test: /\.coffee$/
      loader: 'babel-loader!coffee-loader'
    }
  ]
  resolve: extensions: [
    '.js'
    '.json'
    '.coffee'
  ]

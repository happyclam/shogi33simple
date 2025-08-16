module.exports = {
  context: __dirname + '',

  entry: {
    js: "./gameGui.js"
  },

  output: {
    path: __dirname + '',
    filename: "./shogi33.js"
  },
  devtool: 'cheap-source-map',
  module: {
    loaders: [
      {
        test: /\.coffee$/,
        loader: 'coffee-loader'
      },
      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      }
    ]
  },
  resolve: {
    modules: [
      "node_modules"
    ],
    extensions: ['.js', '.json', '.coffee']
  }
}

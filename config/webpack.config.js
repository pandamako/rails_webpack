// Example webpack configuration with asset fingerprinting in production.
'use strict';

var path = require('path');
var webpack = require('webpack');
var StatsPlugin = require('stats-webpack-plugin');

// must match config.webpack.dev_server.port
var devServerPort = 3808;

// set NODE_ENV=production on the environment to add asset fingerprints
var production = process.env.NODE_ENV === 'production';
var development = process.env.NODE_ENV === 'development';
//Плагин, который позволяет вычленять из лоадера готовый текст
// const ExtractTextPlugin = require('extract-text-webpack-plugin');

var config = {
  entry: {
    // Sources are expected to live in $app_root/webpack
    'application': './webpack/application.js',
    // 'application': './webpack/application.css'
  },

  output: {
    // Build assets directly in to public/webpack/, let webpack know
    // that all webpacked assets start with webpack/

    // must match config.webpack.output_dir
    path: path.join(__dirname, '..', 'public', 'webpack'),
    publicPath: '/webpack/',

    filename: production ? '[name]-[chunkhash].js' : '[name].js'
  },

  resolve: {
    root: path.join(__dirname, '..', 'webpack'),
    modulesDirectories: ['node_modules'],

    //Расширения. Если перечислить тут расширения разных файлов, то можно в require не писать расширение
    extensions: ['', '.js', '.coffee']
  },

  module: {
    //Загрузчики используются для обработки различных типов файлов, для транспиллинга и т.д.
    //Загрузчик - это обычный nodejs модуль
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' }
      // {
        // test: /\.(css|scss|sass)$/,
        // loader: ExtractTextPlugin.extract("style", "css!postcss!sass")
      // }
    ]
  },

  plugins: [
    // must match config.webpack.manifest_filename
    new StatsPlugin('manifest.json', {
      // We only need assetsByChunkName
      chunkModules: false,
      source: false,
      chunks: false,
      modules: false,
      assets: true
    })
    // new ExtractTextPlugin(development ? 'css/[name].css' : 'css/[name].[contenthash].css')
  ]
};

if (production) {
  config.plugins.push(
    new webpack.NoErrorsPlugin(),
    new webpack.optimize.UglifyJsPlugin({
      compressor: { warnings: false },
      sourceMap: false
    }),
    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') }
    }),
    new webpack.optimize.DedupePlugin(),
    new webpack.optimize.OccurenceOrderPlugin()
  );
} else {
  config.devServer = {
    port: devServerPort,
    headers: { 'Access-Control-Allow-Origin': '*' }
  };
  config.output.publicPath = '//localhost:' + devServerPort + '/webpack/';
  // Source maps
  config.devtool = 'cheap-module-eval-source-map';
}

module.exports = config;

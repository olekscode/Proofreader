# Proofreader

![Build status](https://github.com/olekscode/Proofreader/workflows/CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/olekscode/Proofreader/badge.svg?branch=master)](https://coveralls.io/github/olekscode/Proofreader?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/olekscode/Proofreader/master/LICENSE)

A tool for proofreading source code and correcting language mistakes (e.g. typos).

## How to install it?

To install `Proofreader`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Proofreader';
  repository: 'github://olekscode/Proofreader/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `Proofreader` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'Proofreader'
  with: [ spec repository: 'github://pharo-ai/Proofreader/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

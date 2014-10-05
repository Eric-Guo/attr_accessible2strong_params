# Attr Accessible TO Strong Params

[![Gem Version](https://badge.fury.io/rb/attr_accessible2strong_params.svg)](http://badge.fury.io/rb/attr_accessible2strong_params)
[![Dependency Status](https://gemnasium.com/Eric-Guo/attr_accessible2strong_params.svg)](https://gemnasium.com/Eric-Guo/attr_accessible2strong_params)
[![Travis CI tests](https://travis-ci.org/Eric-Guo/attr_accessible2strong_params.png)](https://travis-ci.org/Eric-Guo/attr_accessible2strong_params)
[![Coverage Status](https://coveralls.io/repos/Eric-Guo/attr_accessible2strong_params/badge.png?branch=master)](https://coveralls.io/r/Eric-Guo/attr_accessible2strong_params?branch=master)

Automatically convert Rails 3 attr_accessible to Rails 4 Strong Parameter

## Installation

    $ gem install attr_accessible2strong_params

## Usage

Run `aa2sp` in your rails root folder and program will do auto convert. (but it clear that you need to review the change.)


## Known issue

Due to the using [unparser](https://github.com/mbj/unparser#usage) to rewrite the source code, so it does not reproduce your source! It produces equivalent source.
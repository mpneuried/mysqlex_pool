# MysqlexPool

[![Travis Build Status](https://img.shields.io/travis/mpneuried/mysqlex_pool.svg)](https://travis-ci.org/mpneuried/mysqlex_pool)
[![Windows Tests](https://img.shields.io/appveyor/ci/mpneuried/mysqlex_pool.svg?label=WindowsTest)](https://ci.appveyor.com/project/mpneuried/mysqlex_pool)
[![Coveralls Coverage](https://img.shields.io/coveralls/mpneuried/mysqlex_pool.svg)](https://coveralls.io/github/mpneuried/mysqlex_pool)

[![Hex.pm Version](https://img.shields.io/hexpm/v/mysqlex_pool.svg)](https://hex.pm/packages/mysqlex_pool)
[![Deps Status](https://beta.hexfaktor.org/badge/all/github/mpneuried/mysqlex_pool.svg?branch=master)](https://beta.hexfaktor.org/github/mpneuried/mysqlex_pool)
[![Hex.pm](https://img.shields.io/hexpm/dt/mysqlex_pool.svg?maxAge=2592000)](https://hex.pm/packages/mysqlex_pool)


A warpper for mysqlex to add connection pooling with poolboy

## Installation

1. Add `mysqlex_pool` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:mysqlex_pool, "~> 0.1.0"}]
end
```

2. Ensure `mysqlex_pool` is started before your application:

```elixir
def application do
  [applications: [:mysqlex_pool]]
end
```

## Usage

### `MysqlexPool.query/1`

run a simple mysql query - [`query/1`](https://hexdocs.pm/mysqlex_pool/MysqlexPool.html#query/1)

**`{ :ok, %Mysqlex.Result{...} } = MysqlexPool.query( "SELECT * FROM test" )`**

**Example:**

```elixir
{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 1, rows: [{1, "Kabul"}] } } = MysqlexPool.query( "SELECT ID, Name FROM `city` WHERE id = 1" )
```

### `MysqlexPool.query/2`

run a mysql query with param substitution - [`query/2`](https://hexdocs.pm/mysqlex_pool/MysqlexPool.html#query/2)

**`{ :ok, %Mysqlex.Result{...} } = MysqlexPool.query( "SELECT * FROM test WHERE id = ?", [ 1337 ] )`**

**Example:**

```elixir
{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 1, rows: [{1, "Kabul"}] } } = MysqlexPool.query( "SELECT ID, Name FROM `city` WHERE id = ?", [ 1 ] )
```

## Config

You can set the configuration within your `config.exs` or just use the environment vars.

- **`username`** *`Binary` default: `root`*: mysql user name. *env-var: `MYSQLEX_POOL_USER`*
- **`password`** *`Binary` default: `root`*: mysql password. *env-var: `MYSQLEX_POOL_PASSWORD`*
- **`hostname`** *`Binary` default: `127.0.0.1`*: mysql host. *env-var: `MYSQLEX_POOL_HOST`*
- **`port`** *`Integer` default: `3306`*: mysql port. *env-var: `MYSQLEX_POOL_PORT`*
- **`database`** *`Binary` default: `test`*: mysql datebase. *env-var: `MYSQLEX_POOL_DATABASE`*
- **`pool_size`** *`Integer` default: `10`*: mysqlex/poolboy pool size. *env-var: `MYSQLEX_POOL_SIZE`*
- **`pool_overflow`** *`Integer` default: `1`*: mysqlex/poolboy pool overflow. *env-var: `MYSQLEX_POOL_OVERFLOW`*
- **`charset`** *`Binary` default: `utf8`*: mysql charset. *env-var: `MYSQLEX_POOL_CHARSET`*

## Development & Benchmarks

All examples and tests are based on the example db `world`.
You can find a copy [here](https://raw.githubusercontent.com/mpneuried/mysqlex_pool/master/_dev/world.sql) or use the [official source](https://dev.mysql.com/doc/index-other.html) and download the `world database`.

### Development

To run the tests just call:
**`make test` or `make t`.**

In this case it'll use the environment in `test.env`.
To use your own just copy it and use `make test=my_custom_test.env test`

### Benchmarks

To run the benchmaks just call:
**`make bench` or `make b`.**

In this case it'll use the environment in `test.env`.
To use your own just copy it and use `make test=my_custom_test.env test`


## Release History

|Version|Date|Description|
|:--:|:--:|:--|
|0.2.1|2018-01-25|Updated dependencies|
|0.2.0|2017-03-17|added configuration, added docs, fixed travis and appveyor ci configs.|
|0.1.0|2017-03-16|initial wip version|

## Infos

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/mysqlex_pool](https://hexdocs.pm/mysqlex_pool).

## Other projects

|Name|Type|Description|
|:--|:--|
|[**ex-redis-sessions**](https://github.com/mpneuried/ex-redis-sessions)|Elixir|An advanced session store for Elixir and NodeJS based on Redis |
|[**mpneuried/docker_distillery**](https://hub.docker.com/r/mpneuried/docker_distillery/)|Docker Image|Create a docker container to be able to build elixir releases via distillery on different os's.|
|[**mpneuried/elixir-alpine**](https://hub.docker.com/r/mpneuried/elixir-alpine/)|Docker Image|A minimal docker container to run elixir|
|[**redis-sessions**](https://github.com/smrchy/redis-sessions)|Node.JS|An advanced session store for NodeJS and Redis|
|[**node-cache**](https://github.com/mpneuried/nodecache)|Node.JS|Simple and fast NodeJS internal caching. Node internal in memory cache like memcached.|
|[**rsmq**](https://github.com/smrchy/rsmq)|Node.JS|A really simple message queue based on redis|
|[**obj-schema**](https://github.com/mpneuried/obj-schema)|Node.JS|Simple module to validate an object by a predefined schema|

## The MIT License (MIT)

Copyright © 2017 M. Peter, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

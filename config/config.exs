# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :mysqlex_pool,
	# mysql user name
	username: { :system, "MYSQLEX_POOL_USER", "root" },
	# mysql password
	password: { :system, "MYSQLEX_POOL_PASSWORD", "root" },
	# mysql host
	hostname: { :system, "MYSQLEX_POOL_HOST", "127.0.0.1" },
	# mysql port
	port: { :system, "MYSQLEX_POOL_PORT", 3306 },
	# mysql datebase
	database: { :system, "MYSQLEX_POOL_DATABASE", "test" },
	# mysqlex/poolboy pool size
	pool_size: { :system, "MYSQLEX_POOL_SIZE", 10 },
	# mysqlex/poolboy pool overflow
	pool_overflow: { :system, "MYSQLEX_POOL_OVERFLOW", 1 },
	# mysql charset
	charset: { :system, "MYSQLEX_POOL_CHARSET", "utf8" }

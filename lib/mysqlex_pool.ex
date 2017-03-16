defmodule MysqlexPool do
	@moduledoc """
	A Simple wrapper around mxsqlex to add pooling
	"""
	use Application

	# See http://elixir-lang.org/docs/stable/elixir/Application.html
	# for more information on OTP Applications
	def start( _type, _args ) do
		start_link( nil )
	end
	
	def start_link( _opts ) do
		import Supervisor.Spec, warn: false

		# Define workers and child supervisors to be supervised
		children = [
			supervisor( MysqlexPool.Pool, [ ] ),
		]

		# See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
		# for other strategies and supported options
		opts = [ strategy: :one_for_one, name: MysqlexPool.Supervisor ]
		Supervisor.start_link( children, opts )
	end

	@doc """
	execute a mysql query

	## Examples

		iex>MysqlexPool.query( "SELECT ID, Name FROM `city` WHERE id = ?", [ 1 ] )
		{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 1, rows: [{1, "Kabul"}] } }
		iex>MysqlexPool.query( "SELECT ID, city.Name as City, Population FROM city WHERE city.CountryCode IN ( SELECT country.Code FROM country WHERE Population < ? ) ORDER BY Population desc LIMIT 0,?", [ 50_000, 2 ] )
		{ :ok, %Mysqlex.Result{columns: ["ID", "City", "Population"], command: :select, last_insert_id: nil, num_rows: 2, rows: [{915, "Gibraltar", 27025}, {553, "George Town", 19600}] } }
	"""
	def query( statement, params ) do
		MysqlexPool.Pool.query( statement, params )
	end

	@doc """
	execute a mysql query

	## Examples

		iex>MysqlexPool.query( "SELECT ID, Name FROM `city` WHERE id = 1" )
		{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 1, rows: [{1, "Kabul"}] } }
	"""
	def query( statement ) do
		MysqlexPool.Pool.query( statement, [] )
	end
end
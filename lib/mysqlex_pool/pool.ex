defmodule MysqlexPool.Pool do
	@moduledoc """
	A library of functions used to create and use a Mysql pool through Mysqlex.
	"""

	use Supervisor

  require Mysqlex.Connection

	####
	# SUPERVISOR API
	####

	@doc """
	start supervisor
	"""
	def start_link do
		Supervisor.start_link( __MODULE__, [ ] )
	end

	@doc """
	init redix pool
	"""
	def init( _ ) do

		pool_opts = [
			name: { :local, __MODULE__ },
			worker_module: Mysqlex.Connection,
			size: get_poolsize( ),
			max_overflow: get_pooloverflow( )
		]
		
		children = [
			:poolboy.child_spec( __MODULE__ , pool_opts, [ username: "world", database: "world", password: "world", hostname: "127.0.0.1" ] )
		]

		supervise( children, strategy: :one_for_one, name: __MODULE__ )
	end

	@doc """
	execute a single sql query

	## Examples

		iex> MysqlexPool.Pool.query( "SELECT ID, Name FROM `city` LIMIT 0,3", [] )
		{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 3, rows: [{1, "Kabul"},{2, "Qandahar"}, {3, "Herat"}] } }
	"""
	def query( statement, args ) do
		:poolboy.transaction( __MODULE__, &Mysqlex.Connection.query( &1, statement, args ) )
	end
	
	defp get_poolsize do
		get_poolsize( Application.get_env( :mysqlex_pool, :pool_size, 100 ) )
	end
	
	defp get_poolsize( poolsize ) when is_binary( poolsize ) do
		String.to_integer( poolsize )
	end
	
	defp get_poolsize( poolsize ) when is_number( poolsize ) do
		poolsize
	end
	
	defp get_poolsize( { :system, envvar } ) do
		get_poolsize( { :system, envvar, 100 } )
	end
	
	defp get_poolsize( { :system, envvar, default } ) do
		sysvar = System.get_env( envvar )
		if sysvar == nil do
			default
		else
			sysvar
		end
	end
	
	defp get_pooloverflow do
		get_pooloverflow( Application.get_env( :mysqlex_pool, :pool_overflow, 5 ) )
	end
	
	defp get_pooloverflow( pooloverflow ) when is_binary( pooloverflow ) do
		String.to_integer( pooloverflow )
	end
	
	defp get_pooloverflow( pooloverflow ) when is_number( pooloverflow ) do
		pooloverflow
	end
	
	defp get_pooloverflow( { :system, envvar } ) do
		get_pooloverflow( { :system, envvar, 5 } )
	end
	
	defp get_pooloverflow( { :system, envvar, default } ) do
		sysvar = System.get_env( envvar )
		if sysvar == nil do
			default
		else
			sysvar
		end
	end
end
defmodule MysqlexPool.Pool do
	@moduledoc """
	A library of functions used to create and use a Mysql pool through Mysqlex.
	"""

	use Supervisor

	require Mysqlex.Connection
	
	@doc """
	execute a single sql query

	## Examples

		iex> MysqlexPool.Pool.query( "SELECT ID, Name FROM `city` LIMIT 0,3", [] )
		{ :ok, %Mysqlex.Result{columns: ["ID", "Name"], command: :select, last_insert_id: nil, num_rows: 3, rows: [{1, "Kabul"},{2, "Qandahar"}, {3, "Herat"}] } }
	"""
	@spec query( String.t, List.t ) :: { :ok, Mysqlex.Result.t } |  { :error, any }
	def query( statement, args ) do
		:poolboy.transaction( __MODULE__, &Mysqlex.Connection.query( &1, statement, args ) )
	end
	
	####
	# SUPERVISOR API
	####

	@doc """
	start supervisor
	"""
	@spec start_link( ) :: { :ok, pid } | :ignore | { :error, { :already_started, pid } | { :shutdown, term } | term }
	def start_link do
		Supervisor.start_link( __MODULE__, [ ] )
	end

	@doc """
	init mysqlex pool
	"""
	@spec init( any ) :: { :ok, tuple }
	def init( _ ) do

		pool_opts = [
			name: { :local, __MODULE__ },
			worker_module: Mysqlex.Connection,
			size: get_conf( :pool_size, 10 ),
			max_overflow: get_conf( :pool_overflow, 1 )
		]
		
		connection_opts = [
			username: get_conf( :username, "root", :string ),
			password: get_conf( :password, "root", :string ),
			hostname: get_conf( :hostname, "127.0.0.1", :string ),
			port: get_conf( :port, 3306, :number ),
			charset: get_conf( :charset, "utf8", :string ),
			database: get_conf( :database )
		]
		
		children = [
			:poolboy.child_spec( __MODULE__ , pool_opts, connection_opts )
		]

		supervise( children, strategy: :one_for_one, name: __MODULE__ )
	end

	
	# ####################
	# PRIVATE FUNCTIONS
	# ####################

	
	defp get_conf( { module, key } ) do
		get_conf( { module, key, nil, :string } )
	end
	
	defp get_conf( { module, key, default } ) do
		get_conf( { module, key, default, :string } )
	end
	
	defp get_conf( { module, key, default, type } ) do
		
		cval = process_conf_env( Application.get_env( module, key, default ) )
	
		case { type, cval } do
			{ _undefined, nil } ->
				nil
			{ :string, val } when is_number( val ) ->
				Integer.to_string( val )
			{ :string, val } when is_binary( val ) ->
				val
			{ :number, val } when is_binary( val ) ->
				String.to_integer( val )
			{ :number, val } when is_number( val ) ->
				val
			{ _undefined, val } ->
				val
		end
	end
	
	defp get_conf( key ) when is_atom( key ) do
		get_conf( { :mysqlex_pool, key, nil, :string } )
	end
	
	defp get_conf( key, default ) do
		case default do
			default when is_number( default ) ->
				get_conf( { :mysqlex_pool, key, default, :number } )
			default when is_binary( default ) ->
				get_conf( { :mysqlex_pool, key, default, :string } )
		end
	end
	
	defp get_conf( key, default, type ) do
		get_conf( { :mysqlex_pool, key, default, type } )
	end
	
	
	defp process_conf_env( { :system, envvar, default } ) do
		sysvar = System.get_env( envvar )
		if sysvar == nil do
			default
		else
			sysvar
		end
	end
	
	defp process_conf_env( val ) do
		val
	end
end

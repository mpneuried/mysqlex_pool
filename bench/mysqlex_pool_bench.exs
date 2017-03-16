defmodule MysqlexPoolBench do
  use Benchfella

  setup_all do
    Application.ensure_all_started(:mysqlex_pool)
    #MysqlexPool.start( nil, nil )
  end

  bench "select one" do
    { :ok, _result } = MysqlexPool.Pool.query( "SELECT ID, Name FROM `city` WHERE id = ?", [ Enum.random(0..4_000) ] )
    :ok
  end

  bench "select with subselect" do
    { :ok, _result } = MysqlexPool.Pool.query( "SELECT ID, city.Name as City FROM city WHERE city.CountryCode IN ( SELECT country.Code FROM country WHERE Population > ? )", [ Enum.random(1000..500_00_000) ] )
    :ok
  end
end
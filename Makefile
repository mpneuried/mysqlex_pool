# import test config
testfile=test.env
ifdef test
testfile=$(test)
endif
include $(testfile)
export $(shell sed 's/=.*//' $(testfile))

info:
	@echo "#######################################\n# INFO \n# - test config file: '$(testfile)'\n# - db user: '$(MYSQLEX_POOL_USER)'\n# - db host: '$(MYSQLEX_POOL_HOST)'\n# - db name: '$(MYSQLEX_POOL_DATABASE)'\n#######################################\n"

t: test
test: info
	MIX_ENV=test mix test --trace $(TESTARG)

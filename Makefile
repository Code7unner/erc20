.PHONY: test
test:
	sudo npm -g install remix-tests && remix-tests tests/ERC20_test.sol
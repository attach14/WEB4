## ДЗ №4 Фаззинг
Я взял контракт ERC20 (он находится в src) и протестировал его с помощью external и internal тестов.

Команды для тестов я использовал такие:

echidna ./test/ERC20External.sol --contract ERC20ExternalHarness  --config ./test/external.config.yaml (для external тестирования)

echidna ./test/ERC20Internal.sol --contract ERC20InternalHarness  --config ./test/internal.config.yaml (для internal тестирования)

Изначально все тесты проходились, чтобы какие-то свойства стали нарушаться я переопределил следующие методы

### mint
Вместо ```_mint(to, amount)``` я сделал ```_mint(to, amount * 2)```, из-за этого в обоих вариантах тестирования падает тест mintTokens(), потому что баланс получателя увеличивается не на amount, а на amount*2, тест падает на проверке 

```assertEq(balanceOf(target), balance_receiver+amount, "Mint failed to update target balance")```;

### transfer
В transfer я сделал похожее изменение и заменил ```_transfer(_msgSender(), to, value)``` на ```_transfer(_msgSender(), to, value * 2)```, из-за этого в обоих вариантах падает тест transfer(), баланс отправителя уменьшается сильнее, чем предполагалось и тест падает на проверке 

```assertEq(balanceOf(address(this)), balance_sender-transfer_value, "Wrong source balance after transfer");```

### transferFrom
В transferFrom я сделал такие же изменения, что и в transfer (увеличил value в два раза), поэтому тест transferFrom падает в обоих вариантах тестирования на той же проверке, что и transfer. Кроме этого я убрал проверку spendAllowance, поэтому в обоих вариантах тестирования падает ещё и тест spendAllowanceAfterTransfer(), потому что величина, которую может перевести отправитель не уменьшается, тест падает на проверке 

```assertEq(allowance(msg.sender, address(this)), current_allowance - transfer_value, "Allowance not updated correctly");```

### balanceOF

После всех предыдущих изменений я решил поменять принцип работы balanceOf и возвращать в нем ```return uint256(uint160(account));```, то есть просто адрес аккаунта, поэтому, очевидно, стали ломаться разные другие тесты, ведь теперь balanceOf не отражает реальные изменения баланса пользователя.

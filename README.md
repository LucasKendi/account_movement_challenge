# Account movement challenge

Esse repositório é um desafio de movimentação financeira.

Seu objetivo é executar a criação e movimentação financeira em contas através de arquivos do tipo csv.
## Tecnologias

Tecnologias utilizadas no projeto:
 - ruby (2.6.3)
 - rails (6.0.3.1)
 - mysql (14.14)

Gems adicionais:
 - Rspec (3.10.0.pre)
 - Rubocop (0.84)
 - Factory Bot (5.2.0)


## Instalação
Clone o projeto:
```bash
$ git clone https://github.com/LucasKendi/account_movement_challenge.git
```
Execute o bundle:
```bash
$ bundle
```
Execute as migrações:
```bash
$ rails db:create
$ rails db:migrate
```

Caso seja necessário, altere o password do arquivo `database.yml` para o seu password do usuário root no mysql

## Uso
Execute a rake passando os seus arquivos csv que devem estar na raiz do projeto:
```bash
$ rails balance:calculate[contas.csv,transacoes.csv]
```
Resultado esperado:
```bash
Criação das contas iniciada em 22:07:36
Criação das contas finalizada 22:07:36

Transações iniciadas em 22:07:36
Transações realizadas em 22:07:39

Conta 100 com saldo de -R$52,00
Conta 101 com saldo de R$5550,00
Conta 102 com saldo de -R$5809,00
Conta 103 com saldo de -R$490,00
Conta 104 com saldo de R$300,00
Conta 105 com saldo de R$600,00
Conta 106 com saldo de R$2570,00
Conta 107 com saldo de R$450,00
Conta 108 com saldo de -R$496,00
Conta 109 com saldo de R$225,25
```

Um exemplo do arquivo contas.csv e transacoes.csv se encontram na raiz do projeto

Rake disponível para visualizar o resumo das contas:
```bash
$ rails balance:summary
```


Para garantir a qualidade do projeto, foram desenvolvidos uma série de testes que podem ser executados com:
```bash
$ bundle exec rspec
```

## Licensa
[MIT](https://choosealicense.com/licenses/mit/)
# Bank tech test

### Introduction
This repo is a practice tech test. The request was to write a simple bank
system that could manage deposits, withdrawals and statement printing.

The proposed solution was written in Ruby.

### Using the program and running tests
Clone or fork this repo and install its dependencies by running bundle install:
```
$ git clone https://github.com/IPbianco/Bank-tech-test.git
$ cd bank-tech-test
$ bundle install
```
All the tests can be run from the command line using RSpec:
```
$ rspec
```
Interaction with the program is via IRB:
```
$ irb
$ require './lib/bank.rb'
```

### Approach
To keep things simple I implemented a Bank class that is initialised with an empty
array of "operations". An operation consists of a hash with the following keys:

- Client id
- Date
- Credit
- Debit
- Balance

Each time a client makes a deposit or a withdrawal a new operation is added to the
array.

This is a sample of how the program works:

We start by creating our bank, we will call it "Gringotts"
```
gringotts = Bank.new
```
A user with id 687 makes a deposit of £100, a withdrawal of £20 and another deposit
of £30
```
gringotts.deposit(687, 100)
gringotts.withdrawal(687, 20)
gringotts.deposit(687, 30)
```
The user asks for the bank statement
```
gringotts.show_statement(687)

date || credit || debit || balance
2018-01-02 || 100 || - || 100
2018-01-02 || - || 20 || 80
2018-01-02 || 30 || - || 110
```

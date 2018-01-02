require 'bank'
require 'date'

describe Bank do

  # Banks
  let(:bank) { described_class.new }

  # Deposits
  let(:deposit_operation_1) do
    { client_id: 1, date: Date.today.to_s, credit: 10, debit: "-", balance: 10 }
  end
  let(:deposit_operation_2) do
    { client_id: 1, date: Date.today.to_s, credit: 80, debit: "-", balance: 90 }
  end
  let(:deposit_operation_3) do
    { client_id: 2, date: Date.today.to_s, credit: 5, debit: "-", balance: 5 }
  end

  # Withdrawals
  let(:withdrawal_operation_1) do
    { client_id: 1, date: Date.today.to_s, credit: "-", debit: 2, balance: 8 }
  end

  describe '#initialize' do
    it 'has an empty array of operations' do
      expect(bank.operations).to eq([])
    end
  end

  describe '#deposit' do

    before(:each) { bank.deposit(1, 10) }

    context 'for the first client' do
      it 'makes a first deposit operation' do
        expect(bank.operations.last).to eq(deposit_operation_1)
      end

      it 'makes a second deposit operation with updated balance' do
        bank.deposit(1, 80)
        expect(bank.operations.last).to eq(deposit_operation_2)
      end
    end

    context 'for the second client' do
      it 'makes a first deposit operation' do
        bank.deposit(2, 5)
        expect(bank.operations.last).to eq(deposit_operation_3)
      end
    end
  end

  describe '#withdrawal' do
    it 'raises an error when insufficient funds' do
      expect { bank.withdrawal(1, 50) }.to raise_error('Insufficient funds')
    end

    it 'makes a withdrawal operation' do
      bank.deposit(1, 10)
      bank.withdrawal(1, 2)
      expect(bank.operations.last).to eq(withdrawal_operation_1)
    end
  end
end

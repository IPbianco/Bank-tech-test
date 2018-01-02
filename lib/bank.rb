require 'date'

class Bank

  attr_reader :operations

  def initialize
    @operations = []
  end

  def deposit(id, amount)
    set_current_client(id)
    @operations << build_hash(credit: amount)
  end

  def withdrawal(id, amount)
    set_current_client(id)
    raise "Insufficient funds" if insufficient_funds?(amount)
    @operations << build_hash(debit: amount)
  end

  def show_statement(id)
    set_current_client(id)
    statement = build_statement
    puts statement
  end

    private

    def set_current_client(id)
      @client_id = id
    end

    def build_hash(credit: "-", debit: "-")
      {
        client_id: @client_id,
        date: Date.today.to_s,
        credit: credit,
        debit: debit,
        balance: get_new_balance(credit, debit)
      }
    end

    def get_new_balance(credit, debit)
      get_current_balance + (credit == "-" ? debit * -1 : credit)
    end

    def get_current_balance
      operations = get_client_operations
      operations.empty? ? 0 : operations.last[:balance]
    end

    def get_client_operations
      @operations.select { |operation| operation[:client_id] == @client_id }
    end

    def insufficient_funds?(amount)
      get_current_balance - amount < 0
    end

    def build_statement
      header = build_header
      lines = build_lines
      return header + lines
    end

    def build_header
      "date " + "||" + " credit " + "||" + " debit " + "||" + " balance" + "\n"
    end

    def build_lines
      operations = get_client_operations
      lines = ""
      operations.each do |operation|
        lines += operation[:date] + " || " + operation[:credit].to_s + " || " +
                 operation[:debit].to_s + " || " + operation[:balance].to_s + "\n"
      end
      return lines
    end
end

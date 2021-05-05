# frozen_string_literal: true

class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 100

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise 'Balance cannot exceed £100!' if bal_limit(top_up)

    @balance += money
  end

  def bal_limit(money)
    value = @balance + money > BALANCE_LIMIT
  end

  def ticket(fare)
    @balance -= fare
  end
end

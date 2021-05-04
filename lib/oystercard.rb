# frozen_string_literal: true

class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 100

  def initialize
    @balance = 0
  end

  def add_money(top_up)
    raise 'Balance cannot exceed £100!' if bal_limit(top_up)

    @balance += top_up
  end

  def bal_limit(top_up)
    value = @balance + top_up > BALANCE_LIMIT
  end

  def ticket(fare)
    @balance -= fare
  end
end
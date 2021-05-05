# frozen_string_literal: true
require 'station.rb'

class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @touch_in = false
    @touch_out = true
    @in_journey = false
    @log = []
  end

  def top_up(money)
    raise 'Balance cannot exceed £90!' if bal_limit(money)

    @balance += money
  end

  def bal_limit(money)
    value = @balance + money > BALANCE_LIMIT
  end

  def touch_in
    fail 'Insufficient funds.' if @balance < MINIMUM_FARE
  end

  def touch_out
    self.deduct(MINIMUM_FARE)
  end

  def in_journey?
    
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end

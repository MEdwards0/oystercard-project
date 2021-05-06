# frozen_string_literal: true
require_relative './station.rb'

class Oystercard
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :history

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @touch_in = false
    @touch_out = true
    @entry_station = []
    @history = []
  end

  def top_up(money)
    raise 'Balance cannot exceed £90!' if bal_limit(money)

    @balance += money
  end

  def bal_limit(money)
    value = @balance + money > BALANCE_LIMIT
  end

  def touch_in(station)
    fail 'Insufficient funds.' if @balance < MINIMUM_FARE

    @entry_station << station
  end

  def touch_out(exit_station)
    self.deduct(MINIMUM_FARE)

    enter = @entry_station[0]
    @history.push({entry: enter, exit: exit_station})

    @entry_station = nil
  end

  def in_journey?
    if entry_station != nil
      true
    else
      false
    end
  end

  private

  def deduct(fare)
    @balance -= fare
  end

end

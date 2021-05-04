# frozen_string_literal: true

require 'oystercard.rb'

describe Oystercard do
  context '#money' do
    it { is_expected.to respond_to :balance }

    it 'can add money to balance' do
      subject.add_money(10)
      expect(subject.balance).to eq(10)
    end

    it 'tests balance limit returns true' do
      expect(subject.bal_limit(101)).to eq true
    end

    it 'limits balance amount' do
      expect { subject.add_money(101) }.to raise_error 'Balance cannot exceed £100!'
    end

    it 'fare can be deducted' do
      subject.add_money(100)
      expect(subject.ticket(4)).to eq 96
    end
  end
end

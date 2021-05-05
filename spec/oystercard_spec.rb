# frozen_string_literal: true

require 'oystercard.rb'

describe Oystercard do
  context '#money' do
    it { is_expected.to respond_to :balance }

    it 'can add money to balance' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it 'tests balance limit returns true' do
      expect(subject.bal_limit(101)).to eq true
    end

    it 'limits balance amount' do
      expect { subject.top_up(101) }.to raise_error 'Balance cannot exceed £90!'
    end

    it 'fare can be deducted' do
      subject.top_up(90)
      subject.send(:deduct, 2) 
      expect(subject.balance).to eq 88
    end
  end

  context '#journey, #touch_in and #touch_out' do
    it { is_expected.to respond_to :touch_in }

    it { is_expected.to respond_to :touch_out }

    it { is_expected.to respond_to :in_journey? }

    it 'needs £1 minumum on card' do
      expect{subject.touch_in}.to raise_error 'Insufficient funds.'
    end

    it 'deducts minimum balance on touch out' do
      subject.top_up(2)
      expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    # it 'stores station on touch in' do
    #   station = double(:name = "King's Cross Station", :speed = 50) 
    # end
  end
end

# subject.send(:deduct, 2) 

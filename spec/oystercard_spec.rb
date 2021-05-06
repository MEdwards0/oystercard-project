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

  context '#in_journey?, #touch_in and #touch_out' do
    # Note: Add checks for touch in & out args
    let(:station_double) { double :name => "King's Cross Station" }

    it { is_expected.to respond_to :touch_in }

    it { is_expected.to respond_to :touch_out }

    it { is_expected.to respond_to :in_journey? }

    it 'needs £1 minumum on card' do
      expect{subject.touch_in(station_double)}.to raise_error 'Insufficient funds.'
    end

    it 'deducts minimum balance on touch out' do
      subject.top_up(5)
      expect {subject.touch_out('')}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'stores station on touch in' do
      #station_double = double(:name => "King's Cross Station")
      subject.top_up(5)
      subject.touch_in(station_double.name)
      expect(subject.entry_station).to include(station_double.name) 
    end

    it 'forgets entry station on touch out' do
      subject.top_up(5)
      subject.touch_in(station_double.name)
      subject.touch_out('')
      expect(subject.entry_station).to eq nil
    end

    it 'sets journey status to true' do
      subject.top_up(5)
      subject.touch_in(station_double.name)
      expect(subject.in_journey?).to eq true
    end
  end

  context '#history' do
    let(:entry_station_double) { double :name => "King's Cross Station" }
    let(:exit_station_double) { double :name => 'Liverpool Street Station' }

    it { is_expected.to respond_to :history }

    it 'is expected to be empty upon initialization' do
      expect(subject.history).to eq([])
    end
    
    it 'stores a hash of entry and exit stations' do
      subject.top_up(5)
      subject.touch_in(entry_station_double.name)
      subject.touch_out(exit_station_double.name)
      expect(subject.history).to include({entry: entry_station_double.name, exit: exit_station_double.name})
    end
  end
end

require 'station.rb'

describe Station do
  context '#inititalize' do
    # let(:subject) { described_class.new(5) }
    
    it 'has zone variable' do
      expect(subject).to respond_to :zone
    end

    it 'has name variable' do
      expect(subject).to respond_to :name
    end
  end
end
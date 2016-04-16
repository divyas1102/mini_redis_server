require 'rspec'

describe Dataset do

  context '#set_values' do
    it 'should add key value to hash' do
      key = 'test'
      value = 'value'
      self.set_values(key,value)
      expect(self.get_value).to eql(key)
    end
  end
end
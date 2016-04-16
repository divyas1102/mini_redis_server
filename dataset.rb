class Dataset
  @my_data = {}

  def self.set_values(key, value)
    begin
      @my_data[key] = value
      'OK'
    rescue
      puts 'ERROR'
    end
  end

  def self.get_value(key)
    @my_data[key]
  end

  def self.get_dbsize
    @my_data.length
  end

  def self.delete(key)
    @my_data.delete(key)
    @my_data
  end

  def self.increment(key)
    @my_data[key] = @my_data[key].to_i + 1
    @my_data[key]
  end
end
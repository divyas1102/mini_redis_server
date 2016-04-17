class Dataset
  @my_data = Hash.new

  def self.set_values(key, value)
    @my_data.inspect
    begin
      @my_data[key] = value
      'OK'
    rescue => e
      'ERROR' + e.inspect
    end
  end

  def self.get_value(key)
    @my_data.include?(key) ? @my_data[key] : 'KEY NOT FOUND'
  end

  def self.get_dbsize
    @my_data.length
  end

  def self.delete(key)
    begin
      @my_data.delete(key)
      'DELETED'
    rescue => e
      'ERROR' + e.inspect
    end
  end

  def self.increment(key)
    @my_data.include?(key) ? @my_data[key].to_i + 1 : 'KEY NOT FOUND'
  end
end
class Ticker < ActiveRecord::Base
  #attr_accessor :open, :close
  validates :date, :presence => true
  
  def retriever
    #puts symbol
    results = MarketBeat.quotes(symbol, date.strftime("%Y-%m-%d"), date.strftime("%Y-%m-%d") )
    if !results.empty? 
      puts date.strftime("%Y-%m-%d")
      puts results.inspect
      stats = results[0]
      self.open = stats[:open]
      self.high = stats[:high]
      self.low = stats[:low]
      self.close = stats[:close]
      self.volume = stats[:volume]
      self.save
    end
    
    results.each do |row|
      day_close = row[:close].to_f
      day_open = row[:open].to_f
      diff = day_close - day_open
      percent_change = (diff / day_open) * 100
      puts percent_change
      if percent_change > 0 
        puts "Gain"
      else
        puts "Loss"
      end
    end
      
  end
  
  def self.retrieve_range (symbol, start_date, end_date)
    (start_date..end_date).each do |day|
      t = Ticker.new
      t.date = day
      t.symbol = symbol
      t.retriever
    end
  end
end  


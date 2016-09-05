require 'httparty'

require './lib/samples/bet_all'
require './lib/samples/play_safe'

class Player
  attr_reader :ip, :name, :score, :moves
  
  class << self
    def locate
      list = [BetAll.new, PlaySafe.new]
      
      ip_parts = local_ip.split('.')
      network = ip_parts[0,3].join('.')
      me = ip_parts.last.to_i
    
      threads = ((2..255).entries).map{|i| "#{network}.#{i}"}.map do |ip|
        Thread.new do
          name = check(ip)
          list << new(ip, name) unless name.nil?
        end
      end
    
      threads.each(&:join)
      
      list
    end
    
    def check ip
      begin
        response = HTTParty.get("http://#{ip}:6001/ping", timeout: 5)
        data = JSON.parse(response.body)

        data['name']
      rescue
      end
    end

    def local_ip
      ips = `ifconfig | grep 'inet '`.split("\n").map do |y| 
        y.scan(/[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/).first
      end
      
      (ips - ['127.0.0.1']).first
    end
  end

  def initialize ip, name
    @ip = ip
    @name = name
    @score = 100
    @moves = []
  end
  
  def to_json options={}
    {ip: ip, name: name, score: score}
  end
  
  def get_move armies
    response = HTTParty.post("http://#{ip}:6001/move", body: {armies: armies, soldiers: score}, timeout: 5)
    data = JSON.parse(response.body)

    soldiers = [[data['soldiers'], 1].max, score].min

    @moves << soldiers
    @score -= soldiers
    
    soldiers
  end
  
  def increment soldiers
    @score += soldiers
  end
  
  def alive?
    @score > 0
  end
end
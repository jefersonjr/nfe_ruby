require 'cobr'
require 'fat'

module NfeRuby
  class Cobr
    attr_accessor :fat, :dup
    
    def initialize
      self.fat = NfeRuby::Fat.new
      self.dup = NfeRuby::Dup.new
    end
    
  end
end
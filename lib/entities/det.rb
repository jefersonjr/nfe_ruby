require 'entities/prod'
require 'entities/imposto'

module NfeRuby
  class Det
    attr_accessor :prod, :imposto, :inf_ad_prod
    
    def initialize
      self.prod = NfeRuby::Prod.new
      self.imposto = NfeRuby::Imposto.new
    end
  end
end
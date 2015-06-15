require 'entities/icms_tot'
require 'entities/issqn_tot'

module NfeRuby
  class Total
    attr_accessor :icms
    attr_accessor :issqn
    
    def initialize
      self.icms = NfeRuby::IcmsTot.new
      self.issqn = NfeRuby::IssqnTot.new
    end
  end
end
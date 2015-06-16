module NfeRuby
  class Imposto
    attr_accessor :v_tot_trib, :icms

    def initialize
      self.icms = NfeRuby::Icms.new
    end
  end
end
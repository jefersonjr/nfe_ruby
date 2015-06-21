module NfeRuby
  class Imposto
    attr_accessor :v_tot_trib, :icms, :ipi, :pis, :cofins, :imposto_devolv, :inf_ad_prod

    def initialize
      self.icms = NfeRuby::Icms.new
      self.ipi = NfeRuby::Ipi.new
      self.cofins = NfeRuby::Cofins.new
      self.pis = NfeRuby::Pis.new
    end
  end
end
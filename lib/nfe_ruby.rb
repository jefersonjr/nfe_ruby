require 'entities/ide'
require 'entities/emit'
require 'entities/dest'
require 'entities/icms'
require 'entities/det'
require 'entities/imposto'
require 'entities/total'
require 'entities/transp'
require 'entities/inf_adic'
require 'nfe_ruby/builder'
require 'nfe_ruby/util'
require 'xmldsig'

module NfeRuby

  CODIGO_UF = { 'RO' => 11, 'AC' => 12, 'AM' => 13, 'RR' => 14, 'PA' => 15, 'AP' => 16, 'TO' => 17,
                'MA' => 21, 'PI' => 22, 'CE' => 23, 'RN' => 24, 'PB' => 25, 'PE' => 26, 'AL' => 27,
                'SE' => 28, 'BA' => 29, 'MG' => 31, 'ES' => 32, 'RJ' => 33, 'SP' => 35, 'PR' => 41,
                'SC' => 42, 'RS' => 43, 'MS' => 50, 'MT' => 51, 'GO' => 52, 'DF' => 53}

  class Nfe
    # Detalhes/Itens da NF-e
    @lista_detalhes = []

    @wsdl = "https://nfe.svrs.rs.gov.br/ws/NfeAutorizacao/NFeAutorizacao.asmx"

    attr_accessor :ide, :emit, :dest, :det, :imposto, :total, :transp, :inf_adic, :cert_file, :priv_key_file, :priv_key_pass, :uf_wsdl
    attr_accessor :chave_acesso

    def detalhes
      @lista_detalhes ||= Array.new
    end

    def add_det(&block)
      item = NfeRuby::Det.new
      detalhes.push item

      if block.present?
        block.call(item)
      else
        item
      end
    end

    def gerar_chave_acesso
      # Chave de acesso: cUF(02) + Ano e mês da emissão (04) + CNPJ (14) + mod (02) + serie (03) + nNF (09) + tpEmis (01) + cNF (08) + cDV (1)
      c_uf = sprintf "%02d" % self.ide.c_uf
      ano_mes = self.ide.dh_emi.strftime("%y%m") if self.ide.dh_emi.present?
      cnpj = self.emit.cnpj_cpf
      mod = sprintf "%02d" % self.ide.mod
      serie = sprintf "%03d" % self.ide.serie
      n_nf = sprintf "%09d" % self.ide.n_nf
      tp_emis = self.ide.tp_emis
      c_nf = "%08d" % self.ide.c_nf

      # Montar chave de acesso
      chave = "#{c_uf}#{ano_mes}#{cnpj}#{mod}#{serie}#{n_nf}#{tp_emis}#{c_nf}"

      # Calcular digito verificador da chave de acesso
      self.ide.c_dv = NfeRuby::Util::calcular_digito_verificador(chave)

      # Retornar chave de acesso + DV
      self.chave_acesso = "#{chave}#{self.ide.c_dv}"
    end

    def initialize(options = {})
      self.ide = NfeRuby::Ide.new
      self.emit = NfeRuby::Emit.new
      self.dest = NfeRuby::Dest.new
      self.imposto = NfeRuby::Imposto.new
      self.total = NfeRuby::Total.new
      self.transp = NfeRuby::Transp.new
      self.inf_adic = NfeRuby::InfAdic.new

      self.uf_wsdl = options[:uf_wsdl]
      self.cert_file = options[:cert_key_file]
      self.priv_key_file = options[:priv_key_file]
      self.priv_key_pass = options[:priv_key_pass]
    end

    def to_builder
      gerar_chave_acesso
      xml_builder = NfeRuby::Builder.new(self)
      xml_builder.to_builder
    end

    def to_xml
      to_builder.to_xml
    end

  end
end

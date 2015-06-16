# nfe_ruby
nfe_ruby é uma API para geração, assinatura e envio do XML NF-e / NFC-e para os serviços dos SEFAZ estaduais.
Baseado na versão 3.10 do projeto NF-e/NFC-e
OBS: O projeto está em fase de implementação, nem todas as tags foram adicionadas ainda.

Status do projeto:
[x] Geração do XML NF-e individual (Em andamento)
[ ] Documentação (TODO)
[ ] Geração do XML NF-e lote (TODO)
[ ] Assinatura do XML NF-e individual (TODO)
[ ] Envio do XML NF-e individual (TODO)
[ ] Envio do XML NF-e lote (TODO)


# Preenchimento dos dados da NF-e
Para geração/assinatura/emissão, é necessário preencher os dados da NF-e:
    # Identificação da NF-e
    nf.ide.c_uf = NfeRuby::CODIGO_UF['RO']      # Código da UF
    nf.ide.c_nf = 1                             # Código único da NF para geração da chave de acesso
    nf.ide.nat_op = "VENDA"                     # Natureza da operação
    nf.ide.ind_pag = 0                          # Indicador de pagamento (0 - Pagamento a vista)
    nf.ide.mod = 55                             # Modelo da NF-e
    nf.ide.serie = 144                          # Série da NF-e
    nf.ide.n_nf = 1985                          # Número único da NF-e
    nf.ide.dh_emi = DateTime.now                # Data de emissão
    nf.ide.dh_sai_ent = DateTime.now            # Data de entrada/saída
    nf.ide.tp_nf = 1                            # Tipo da NF-e (1 - Saída)
    nf.ide.id_dest = 1                          # Local destino da operação (1 - Operação interna)
    nf.ide.c_mun_fg = 1100205                   # Cód. mun. gerador do ICMS
    nf.ide.tp_imp = 1                           # Tipo de impressão da DANFE (1 - DANFE normal, retrato)
    nf.ide.tp_emis = 1                          # Tipo de emissão (1 - Emissão normal)
    nf.ide.tp_amb = 2                           # Tipo de ambiente (2 - Homologação)
    nf.ide.fin_nfe = 1                          # Finalidade da NF-e (1 - NFe normal)
    nf.ide.ind_final = 1                        # Indicador de operação Consumidor Final (1 - Consumidor final)
    nf.ide.ind_pres = 1                         # Indicador de presença do comprador (1 - Operação presencial)
    nf.ide.proc_emi = 0                         # Identificador do processo de emissão (0 - Aplicativo contribuinte)
    nf.ide.ver_proc = "nfe_ruby 1.0"            # Versão do aplicativo emissor da NF-e

    # Dados do emitente da NF-e
    nf.emit.cnpj_cpf = "07435640000173"         # CNPJ
    nf.emit.x_nome = "NF-E HOMOLOGAÇÃO"         # Razão social
    nf.emit.x_fant = "NF-E HOMOLOGACAO"         # Nome fantasia
    nf.emit.ender_emit.x_lgr = "AV CUIABA"      # Logradouro
    nf.emit.ender_emit.nro = "2554"             # Número
    nf.emit.ender_emit.x_cpl = ""               # Complemento
    nf.emit.ender_emit.x_bairro = "CENTRO"      # Bairro
    nf.emit.ender_emit.c_mun = "1100049"        # Código IBGE do município
    nf.emit.ender_emit.x_mun = "CACOAL"         # Nome do município
    nf.emit.ender_emit.uf = "RO"                # UF do município
    nf.emit.ender_emit.cep = "78976005"         # CEP
    nf.emit.ender_emit.c_pais = 1058            # Código do país (1058 - BRASIL)
    nf.emit.ender_emit.x_pais = "BRASIL"        # Nome do país
    nf.emit.ender_emit.fone = "6934414256"      # Telefone
    nf.emit.ie = "00000001373773"               # Insc. estadual
    nf.emit.im = "001"                          # Insc. municipal
    nf.emit.cnae = "0000001"                    # CNAE
    nf.emit.crt = 3                             # Código regime tributário (3 - Regime normal)

    # Dados do destinatário
    nf.dest.cnpj_cpf = "01236933000145"         # CNPJ
    nf.dest.x_nome = "NF-E HOMOLOGACAO"         # Razão social
    nf.dest.ender_dest.x_lgr = "AV CUIABA"      # Logradouro
    nf.dest.ender_dest.nro = "2554"             # Número
    nf.dest.ender_dest.x_bairro = "CENTRO"      # Bairro
    nf.dest.ender_dest.c_mun = "3550308"        # Código IBGE município
    nf.dest.ender_dest.x_mun = "SAO PAULO"      # Nome município
    nf.dest.ender_dest.uf = "SP"                # UF município
    nf.dest.ender_dest.cep = "78976005"         # CEP
    nf.dest.ender_dest.c_pais = 1058            # Código país (1058 - BRASIL)
    nf.dest.ender_dest.x_pais = "BRASIL"        # Nome do país
    nf.dest.ender_dest.x_cpl = "teste"          # Complemento
    nf.dest.ender_dest.fone = "6934414256"      # Telefone
    nf.dest.ie = ""                             # Insc. estadual
    nf.dest.email = "jeferson@supersys.com.br"  # Email

    # DETALHES DA NF / Itens que compõe a NF-e
    nf.add_det do |item|
      item.prod.n_item = 1                      # Número sequencial do item
      item.prod.c_prod = "001"                  # Código do produto
      item.prod.c_ean = ""                      # Código EAN do produto
      item.prod.x_prod = "Teste"                # Descrição do produto
      item.prod.ncm = "60063200"                # NCM
      item.prod.cfop = 5122                     # CFOP
      item.prod.u_com = "KG"                    # Un. comercialização
      item.prod.q_com = 1                       # Qtde comercialização
      item.prod.v_un_com = 20                   # Valor und. comercialização
      item.prod.v_prod = 20                     # Valor do produto
      item.prod.c_ean_trib = ""                 # Código EAN de tributação
      item.prod.u_trib = "KG"                   # Unidade de tributação
      item.prod.q_trib = 1                      # Qtde tributação
      item.prod.v_un_trib = 20                  # Valor und. tributação
      item.prod.ind_tot = 1                     # Indicador totalização da NF-e (1 - Valor item compõe o total da NF)
      item.imposto.icms.cst = '00'              # CST do produto (40 - Isenta)
      item.imposto.icms.orig = 0                # Origem do produto (0 - nacional...)
    end

    # Dados do transporte
    nf.transp.mod_frete = 1                     # Modalidade do frete (1 - Por conta do destinatario)

    # Totalização da NF-e (somatório dos itens)
    nf.total.icms.v_bc = 0                      # Valor base cálculo
    nf.total.icms.v_icms = 0                    # Valor do ICMS
    nf.total.icms.v_bc_st = 0                   # Valor do ICMS - ST
    nf.total.icms.v_st = 0                      # Valor ST
    nf.total.icms.v_prod = 20                   # Valor total dos produtos
    nf.total.icms.v_frete = 0                   # Valor do frete
    nf.total.icms.v_seg = 0                     # Valor seguro
    nf.total.icms.v_desc = 0                    # Valor total desconto
    nf.total.icms.v_ii = 0                      # Valor II
    nf.total.icms.v_ipi = 0                     # Valor IPI
    nf.total.icms.v_pis = 0                     # Valor PIS
    nf.total.icms.v_cofins = 0                  # Valor COFINS
    nf.total.icms.v_outro = 0                   # Valor OUTROS
    nf.total.icms.v_nf = 20                     # Valor total da NF


# Geração do XML
Para gerar o XML de uma NF-e, basta chamar o método "to_xml"
ex:
  conteudo_xml = nf.to_xml

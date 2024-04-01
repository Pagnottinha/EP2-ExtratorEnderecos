class Extrator

  def initialize(endereco)
    @endereco = endereco

    @tipo = "N/A"
    @nome = "N/A"
    @numero = "N/A"
    @complemento = "N/A"
    @bairro = "N/A"
    @cidade = "N/A"
    @estado = "N/A"
    @cep = "N/A"
  end

  def extrair
    r_tipo = /(?<Tipo>([Aa]eroporto|[Aa]lameda|[Áá]rea|[Aa]venida|[Aa]v.?|[Cc]ampo|[Cc]hácara|[Cc]olônia|[Cc]ondomínio|[Cc]onjunto|[Dd]istrito|[Ee]splanada|[Ee]stação|[Ee]strada|[Ff]avela|[Ff]azenda|[Ff]eira|[Jj]ardim|[Ll]adeira|[Ll]ago|[Ll]agoa|[Ll]argo|[Ll]oteamento|[Mm]orro|[Nn]úcleo|[Pp]arque|[Pp]assarela|[Pp]átio|[Pp]raça|[Qq]uadra|[Rr]ecanto|[Rr]esidencial|[Rr]odovia|[Rr]ua|[Ss]etor|[Ss]ítio|[Tt]ravessa|[Tt]recho|[Tt]revo|[Vv]ale|[Vv]ereda|[Vv]ia|[Vv]iaduto|[Vv]iela|[Vv]ila))/
    r_nome = /\s(?<Nome>[A-zÀ-ú]+\.?(\s[A-zÀ-ú]+)*)/
    r_numero = /\s?[\,\-]\s(?<Numero>\d+)/
    # primeira parte para casos padrões e segunda parte é para casos de andares 1º andar como exemplo
    r_complemento = /(\s?[\-\,]\s(?<Complemento>(([A-zÀ-ú]+(\s[A-zÀ-ú0-9]+)*|[1-9][0-9]*º\s[A-zÀ-ú0-9]+)(\,\s)?)+))?/
    r_bairro = /(?<Bairro>[A-zÀ-ú]+(\s[A-zÀ-ú]+)*)?/
    r_cidade = /(?<Cidade>[A-zÀ-ú]+(\s[A-zÀ-ú]+)*)/
    r_estado = /(?<Estado>[A-Z]{2})/
    r_cep = /(?<CEP>\d{5}\-\d{3})/

    match_inicio = @endereco.match("#{r_tipo}#{r_nome}#{r_numero}#{r_complemento}")
    match_regiao = @endereco.match("\s#{r_bairro}([\s\-\.\,\\\/])+#{r_cidade}([\s\-\.\,\\\/])+#{r_estado}")
    match_cep = @endereco.match(r_cep)

    if match_inicio != nil
      @tipo = match_inicio[:Tipo]
      @nome = match_inicio[:Nome]
      @numero = match_inicio[:Numero]
      @complemento = match_inicio[:Complemento] == nil ? "N/A" : match_inicio[:Complemento]
    end

    if match_regiao != nil
      @bairro = match_regiao[:Bairro] == nil ? "N/A" : match_regiao[:Bairro]
      @cidade = match_regiao[:Cidade]
      @estado = match_regiao[:Estado]
    end

    if match_cep != nil
      @cep = match_cep[:CEP]
    end

  end

  def mostrar
    "Endereço: #{@endereco}
    \rTipo: #{@tipo}
    \rNome: #{@nome}
    \rNumero: #{@numero}
    \rComplemento: #{@complemento}
    \rBairro: #{@bairro}
    \rCidade: #{@cidade}
    \rEstado: #{@estado}
    \rCEP: #{@cep}"
  end
end
#texto = "Teste teste, Teste testeTeste teste  Av. Eng. Eusébio Stevaux - 823 - 1º andar - Santo Amaro, São Paulo - SP 04696-000"
texto = "Teste teste, Teste testeTeste teste - Santo Amaro, São Paulo - SP 04696-000"
extr = Extrator.new(texto)
extr.extrair
puts extr.mostrar

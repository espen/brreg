require 'brreg/version'
require 'net/http'
require 'json'

module Brreg
  BrregURI = 'https://data.brreg.no/enhetsregisteret/api/enheter'
  def self.find_by_orgnr(orgnr)
    if !orgnr
      puts "Ugyldig verdi"
      return false
    else
      if orgnr.class == String
        orgnr = orgnr.gsub(/\D/, '')
        if orgnr.empty? || orgnr.length != 9
          puts "Ugyldig verdi"
          return false
        end
      end
    end
    res = get_json( { :organisasjonsnummer => orgnr } )
    if res.is_a?(Net::HTTPSuccess)
      jsonres = JSON.parse(res.body)
      matches = jsonres['_embedded']['enheter']
      if matches.length > 0
        company = matches.first
        puts "\n"
        puts "\e[32mViser oppføring for orgnr #{orgnr}\e[0m"
        puts "\n"
        puts company['navn']
        puts company['forretningsadresse']['adresse']
        puts company['forretningsadresse']['postnummer'] + ' ' + company['forretningsadresse']['poststed']
        if !company['postadresse'].empty?
          puts 'Postadresse:'
          puts company['postadresse']['adresse']
          puts company['postadresse']['postnummer'] + ' ' + company['postadresse']['poststed']
        end
      else
        puts "Fant ingen oppføring for #{orgnr}"
      end
    end
  end

  def self.find_by_domain(domain)
    res = `whois #{domain}`
    res.force_encoding('BINARY').encode!('UTF-8', :invalid => :replace, :undef => :replace)
    if res.gsub('Id Number').first
      orgnr = /\Id Number..................:\s(\d{9})/
      if res.match(orgnr)
        Brreg.find_by_orgnr( res.scan(orgnr).first.first )
        puts "\nBasert på Whois fra domenet #{domain}"
      else
        puts "Domenet har ikke et vanlig orgnr."
      end
    elsif res.gsub('% No match').first
      puts "Domenet #{domain} er ikke registert"
    else
      puts "Ukjent svar fra Whois. Det er kun mulig å søke på .no domener."
    end
  end

  def self.find(query)
    puts "\n"
    puts "\e[32mTreff i Enhetsregisteret basert på søket '#{query}'\e[0m"
    puts "\n"
    res = self.get_json( { :navn => query } )
    if res.is_a?(Net::HTTPSuccess)
      jsonres = JSON.parse(res.body)
      matches = jsonres['_embedded']['enheter']
      if matches.length > 0
        if matches.length == 1
          puts "Fant 1 oppføring"
          Brreg.find_by_orgnr( matches.first['organisasjonsnummer'] )
        else
          for entry in matches
            puts entry['organisasjonsnummer'] + ' ' + entry['navn']
          end
        end
      else
        puts "Fant ingen oppføringer med navn #{query}"
      end
    end
  end

  def self.version
    VERSION
  end

  private

  def self.get_json(params)
    uri = URI(BrregURI)
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end
end
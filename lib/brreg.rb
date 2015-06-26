require 'brreg/version'
require 'net/http'
require 'json'

module Brreg
  BrregURI = 'http://hotell.difi.no/api/json/brreg/enhetsregisteret'
  def self.find_by_orgnr(orgnr)
    res = get_json( { :orgnr => orgnr } )
    if res.is_a?(Net::HTTPSuccess)
      jsonres = JSON.parse(res.body)
      if jsonres['posts'].to_i > 0
        company = jsonres['entries'].first
        puts "\n"
        puts "\e[32mViser oppføring for orgnr #{orgnr}\e[0m"
        puts "\n"
        puts company['navn']
        puts company['forretningsadr']
        puts company['forradrpostnr'] + ' ' + company['forradrpoststed']
        if !company['postadresse'].empty?
          puts 'Postadresse:'
          puts company['postadresse']
          puts company['ppostnr'] + ' ' + company['ppoststed']
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
        Brreg.find_by_orgnr( res.scan(orgnr).first.first.to_i )
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
    res = self.get_json( { :query => query } )
    if res.is_a?(Net::HTTPSuccess)
      jsonres = JSON.parse(res.body)
      matches = jsonres['posts'].to_i
      if matches > 0
        if matches == 1
          puts "Fant 1 oppføring"
          Brreg.find_by_orgnr( jsonres['entries'].first['orgnr'] )
        else
          for entry in jsonres['entries']
            puts entry['orgnr'] + ' ' + entry['navn']
          end
        end
      else
        puts "Fant ingen oppføringer med navn #{query}"
      end
    end
  end

  private

  def self.get_json(params)
    uri = URI(BrregURI)
    uri.query = URI.encode_www_form(params)
    Net::HTTP.get_response(uri)
  end
end
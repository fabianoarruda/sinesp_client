require "sinesp_client/version"
require 'net/http'
require 'uri'
require 'openssl'
require 'securerandom'
require 'nokogiri'

module SinespClient

  def self.lat
    rand(-90.000000000...90.000000000)
  end

  def self.long
    rand(-180.000000000...180.000000000)
  end

  def self.search(plate)

    key = "#8.1.0#Mw6HqdLgQsX41xAGZgsF"
    digest = OpenSSL::Digest.new('sha1')
    hash = OpenSSL::HMAC.hexdigest(digest, plate + key, plate)

    body = "<v:Envelope xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:d=\"http://www.w3.org/2001/XMLSchema\" xmlns:c=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:v=\"http://schemas.xmlsoap.org/soap/envelope/\">
             <v:Header>
              <b>Google Android SDK built for x86</b>
              <c>ANDROID</c>
              <d>8.1.0</d>
              <e>4.3.2</e>
              <f>10.0.2.15</f>
              <g>#{hash}</g>
              <h>#{long}</h>
              <i>#{lat}</i>
              <k />
              <l>#{Time.now}</l>
              <m>8797e74f0d6eb7b1ff3dc114d4aa12d3</m>
             </v:Header>
             <v:Body>
              <n0:getStatus xmlns:n0=\"http://soap.ws.placa.service.sinesp.serpro.gov.br/\">
               <a>#{plate}</a>
              </n0:getStatus>
             </v:Body>
            </v:Envelope>"


    headers = { "Content-type" => "application/x-www-form-urlencoded; charset=UTF-8",
                "Accept" => "text/plain, */*; q=0.01",
                "Cache-Control" => "no-cache",
                "Pragma" => "no-cache",
                "Content-length" => body.length.to_s,
                "User-Agent" => "SinespCidadao/4.2.3 CFNetwork/808.1.4 Darwin/16.1.0"
    }

    #begin

    uri = URI.parse("https://189.9.194.154/sinesp-cidadao/mobile/consultar-placa/v3")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.body = body

    response = http.request(request).body

    #rescue
    #  return nil
    #end

    dom = Nokogiri::XML(response)

    node = dom.at_xpath('//return')

    parsed_response = node.element_children.each_with_object(Hash.new) do |e, h|
      h[e.name.to_sym] = e.content
    end

    #If the query is valid, "codigoRetorno" will be 0. Otherwise something went wrong. Just return nil.
    # if parsed_response[:codigoRetorno] == "0"
    #   parsed_response
    # else
    #   nil
    # end

  end

end

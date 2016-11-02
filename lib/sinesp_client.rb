require "sinesp_client/version"
require 'openssl'
require 'httparty'

module SinespClient

  include HTTParty

  def self.lat
    rand(-90.000000000...90.000000000)
  end

  def self.long
    rand(-180.000000000...180.000000000)
  end

  def self.search(plate)

    key = "3ktTqS63LBPlOT3WgFlk"
    digest = OpenSSL::Digest.new('sha1')
    hash = OpenSSL::HMAC.hexdigest(digest, plate + key, plate)

    body = "<?xml version='1.0' encoding='utf-8'?>
                <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">
                  <soap:Header>
                  <b>iPhone</b>
                  <c>iPhone OS</c>
                  <j></j>
                  <i>#{lat}</i>
                  <m>1204fdd387279490261aaf95a6567f64</m>
                  <e>SinespCidadao</e>
                  <f>10.0.0.1</f>
                  <g>#{hash}</g>
                  <d>9.1</d>
                  <h>#{long}</h>
                  <k>#{SecureRandom.uuid}</k>
                  <l>#{Time.now}</l>
                  </soap:Header>
                  <soap:Body>
                    <webs:getStatus xmlns:webs=\"http://soap.ws.placa.service.sinesp.serpro.gov.br/\">
                    <a>#{plate}</a>
                    </webs:getStatus>
                  </soap:Body>
                </soap:Envelope>"

    headers = { "Content-type" => "text/xml; charset=utf-8",
                "Timeout" => "30000",
                "Content-length" => body.length.to_s,
                "User-Agent" => "SinespCidadao / 3.0.2.1 CFNetwork / 758.2.8 Darwin / 15.0.0"
    }


    #begin

      response = post("http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/mobile/consultar-placa", body: body, headers: headers, timeout: 10)

    #rescue
    #  return nil
    #end


    #If the query is valid, "codigoRetorno" will be 0. Otherwise something went wrong. Just return nil.
    #if response["Envelope"]["Body"]["getStatusResponse"]["return"]["codigoRetorno"] == "0"
      response["Envelope"]["Body"]["getStatusResponse"]["return"]
    #else
    #  nil
    #end

  end

end

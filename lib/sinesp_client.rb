require "sinesp_client/version"
require 'openssl'
require 'httparty'
require 'securerandom'

module SinespClient

  include HTTParty

  def self.lat
    rand(-90.000000000...90.000000000)
  end

  def self.long
    rand(-180.000000000...180.000000000)
  end

  def self.search(plate, opts={})

    key = "TRwf1iBwvCoSboSscGne"
    digest = OpenSSL::Digest.new('sha1')
    hash = OpenSSL::HMAC.hexdigest(digest, plate + key, plate)

    body = "<?xml version='1.0' encoding='utf-8'?>
                <soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\">
                  <soap:Header>
                  <b>motorola XT1078</b>
                  <c>ANDROID</c>
                  <i>#{lat}</i>
                  <m>8797e74f0d6eb7b1ff3dc114d4aa12d3</m>
                  <e>4.1.1</e>
                  <f>10.0.0.1</f>
                  <g>#{hash}</g>
                  <d>6.0</d>
                  <h>#{long}</h>
                  <k />
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
    if opts[:proxy_addr].present? && opts[:proxy_port].present?
      response = post("http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/mobile/consultar-placa", body: body, headers: headers, timeout: 10, http_proxyaddr: opts[:proxy_addr], http_proxyport: opts[:proxy_port])
    elsif opts[:proxy_addr].present? && opts[:proxy_port].present? && opts[:proxy_user].present? && opts[:proxy_pass].present?
      response = post("http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/mobile/consultar-placa", body: body, headers: headers, timeout: 10, http_proxyaddr: opts[:proxy_addr], http_proxyport: opts[:proxy_port], http_proxyuser: opts[:proxy_user], http_proxypass: opts[:proxy_pass])
    else
      response = post("http://sinespcidadao.sinesp.gov.br/sinesp-cidadao/mobile/consultar-placa", body: body, headers: headers, timeout: 10)
    end
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

require "sinesp_client/version"
require 'openssl'
require 'httparty'
require 'securerandom'

module SinespClient
  include HTTParty

  BASE_URL = 'sinespcidadao.sinesp.gov.br'.freeze
  SECRET_KEY = 'XvAmRTGhQchFwzwduKYK'.freeze

  def self.search(plate)
    @plate = plate.gsub(/\W+/, '')

    response = post(
      "https://#{BASE_URL}/sinesp-cidadao/mobile/consultar-placa/v2",
      body: body,
      headers: header,
      timeout: 10,
      cookies: captcha_cookie,
      verify: false
    )

    response["Envelope"]["Body"]["getStatusResponse"]["return"].to_h
  end

  private

  def self.captcha_cookie
    response = get("https://#{BASE_URL}/sinesp-cidadao/captchaMobile.png", verify: false)
    cookies = response.headers['set-cookie']
    {
      JSESSIONID: parse_cookie_to_jsessionid(cookies)
    }
  end

  def self.parse_cookie_to_jsessionid(cookie)
    cookie.split(';').map{
      |value| value if value.include?('JSESSION')
    }.compact.first
  end

  def self.lat
    rand(-90.000000000...90.000000000)
  end

  def self.long
    rand(-180.000000000...180.000000000)
  end

  def self.generate_token
    digest = OpenSSL::Digest.new('sha1')
    OpenSSL::HMAC.hexdigest(digest, @plate + SECRET_KEY, @plate)
  end

  def self.header
    {
      "Timeout" => "30000",
      "Content-length" => body.length.to_s,
      "User-Agent" => "SinespCidadao / 3.0.2.1 CFNetwork / 758.2.8 Darwin / 15.0.0",
      "Accept" =>  "text/plain, */*; q=0.01",
      "Cache-Control" =>  "no-cache",
      "Content-Length" =>  "661",
      "Content-Type" =>  "application/x-www-form-urlencoded; charset=UTF-8",
      "Host" =>  "#{BASE_URL}",
      "Connection" => "close"
    }
  end

  def self.body
    "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>
      <v:Envelope xmlns:v='http://schemas.xmlsoap.org/soap/envelope/'>
        <v:Header>
          <b>Samsung GT-I9192</b>
          <c>ANDROID</c>
          <d>6.0.1</d>
          <i>#{lat}</i>
          <e>4.1.5</e>
          <f>10.0.0.1</f>
          <g>#{generate_token}</g>
          <k>#{SecureRandom.uuid}</k>
          <h>#{long}</h>
          <l>#{Time.now}</l>
          <m>8797e74f0d6eb7b1ff3dc114d4aa12d3</m>
        </v:Header>
        <v:Body>
          <n0:getStatus xmlns:n0='http://soap.ws.placa.service.sinesp.serpro.gov.br/'>
            <a>#{@plate}</a>
          </n0:getStatus>
        </v:Body>
      </v:Envelope>"
  end
end

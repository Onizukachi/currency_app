# frozen_string_literal: true

module ApiServices
  require 'cgi'
  require 'nokogiri'

  class CbrApiClient
    BASE_URL = "http://www.cbr.ru/scripts/XML_daily.asp"

    def get(date=nil) # returns data for the current day without the parameter
      query_data = date && "date_req=#{CGI.escape(format_date(date))}"
      response = RestClient.get("#{BASE_URL}?#{query_data}")

      Nokogiri::XML response.body
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.error("Api CBR response code #{e.http_code}: #{e.message}")
      return
    end

    private
    def format_date(date)
      date.to_s.split("-").reverse.join('/')
    end
  end
end

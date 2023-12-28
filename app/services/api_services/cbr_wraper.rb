# frozen_string_literal: true

module ApiServices
  class CbrWraper
    include Singleton

    class << self
      delegate :get_rates_for_date, to: :instance
    end

    def initialize
      @cbr_client = CbrApiClient.new
    end

    def get_rates_for_date(date)
      xml_data = @cbr_client.get(date:)

      return if xml_data.blank?

      parse_result(xml_data)
    end

    private

    attr_reader :kp_client

    def parse_result(data)
      valutes = data.xpath('//ValCurs//Valute').select { |row| %w[USD EUR CNY].include? row.xpath('CharCode').text }
      valutes.map do |valute|
        char_code = valute.xpath('CharCode').text
        nominal = valute.xpath('Nominal').text.to_i
        value = valute.xpath('Value').text.gsub(/,/, '.').to_f

        rate = value / nominal

        { currency: char_code, rate: }
      end
    end
  end
end
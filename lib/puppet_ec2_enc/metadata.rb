require 'net/http'

module PuppetEc2Enc
  class Metadata
    METAURL      = 'http://169.254.169.254/latest/meta-data'
    REGION_REGEX = %r(\A(?:us|eu|ap|sa|ca){1}-(?:east|west|southeast|central|south|northeast){1}-[0-9])

    def self.instance_id
      request('instance-id')
    end

    def self.instance_type
      request('instance-type')
    end

    def self.availability_zone
      request('placement/availability-zone')
    end

    def self.region
      az = availability_zone
      az[REGION_REGEX]
    end

    private

    def self.request(category)
      uri      = URI.parse("#{METAURL}/#{category}")
      response = Net::HTTP.get_response(uri)

      case response
      when Net::HTTPSuccess then
        response.body
      else
        nil
      end
    end
  end
end

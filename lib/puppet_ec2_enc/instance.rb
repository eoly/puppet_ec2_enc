module PuppetEc2Enc
  class Instance
    attr_accessor :ec2

    def initialize
      @ec2 = Aws::EC2::Client.new
    end

    def self.client
      self.new
    end

    def by_private_dns(fqdn)
      filter_hash = {
        name: 'private-dns-name',
        values: [fqdn]
      }

      reservations = filtered_search(filter_hash)

      raise RuntimeError.new(
        "Did not find EC2 instance named #{fqdn}!"
      ) if reservations.nil?

      raise RuntimeError.new(
        "Somehow found more than one EC2 instance named #{fqdn}!"
      ) if reservations.count > 1

      return reservations[0].instances[0]
    end

    private

    def filtered_search(filter_hash = {})
      result = ec2.describe_instances({
        filters: [
          filter_hash
        ]
      })

      return nil if result.reservations.count == 0
      return result.reservations
    end
  end
end

require 'dm-core'
require 'dm-timestamps'

require 'be_accountable/entry'

module BeAccountable
  class Responsibility
    include DataMapper::Resource

    property :id, Serial
    property :title, String
    property :created_on, Date
    
    has n, :entries, :model => 'BeAccountable::Entry'

    def self.for_date(date)
      all(:created_on.lte => date)
    end
    
    def complete_for?(date)
      !entries.for_date(date).nil?
    end
  end
end

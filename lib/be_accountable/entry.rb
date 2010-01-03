require 'dm-core'
require 'dm-timestamps'

module BeAccountable
  class Entry
    include DataMapper::Resource

    property :id, Serial
    property :responsibility_id, Integer
    property :created_on, Date

    belongs_to :responsibility, :model => 'BeAccountable::Responsibility', :child_key => [:responsibility_id]

    def self.for_date(date)
      first(:created_on => date)
    end
  end
end

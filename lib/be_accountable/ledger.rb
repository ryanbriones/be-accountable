require 'be_accountable/responsibility'

module BeAccountable
  class Ledger
    attr_reader :responsibilities

    def initialize(date)
      @date = date
      @responsibilities = BeAccountable::Responsibility.for_date(date)
    end

    def complete?
      return false if @responsibilities.empty?
      @responsibilities.all? { |responsibility| responsibility.complete_for?(@date) }
    end

    def partially_complete?
      return false if @responsibilities.empty?
      @responsibilities.any? { |responsibility| responsibility.complete_for?(@date) }
    end

    def self.complete_for?(date)
      ledger = Ledger.new(date)
      ledger.complete?
    end

    def self.partially_complete_for?(date)
      ledger = Ledger.new(date)
      ledger.partially_complete?
    end

    def results
      @responsibilities.inject({}) { |acc, cur|
        acc[cur.title] = cur.complete_for?(@date)
        acc
      }
    end
  end
end

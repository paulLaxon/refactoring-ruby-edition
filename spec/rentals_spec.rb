# require 'spec_helper'
require 'byebug'
require './rentals'

describe 'Rentals' do
  bob = Customer.new('Bob')
  henry = Customer.new('Henry')
  sarah = Customer.new('Sarah')

  batman = Movie.new('Batman', 0)
  dune = Movie.new('Dune', 1)
  thomas = Movie.new('Thomas', 2)

  bob.add_rental(Rental.new(batman, 3))
  bob.add_rental(Rental.new(dune, 3))
  henry.add_rental(Rental.new(batman, 2))
  henry.add_rental(Rental.new(dune, 1))
  henry.add_rental(Rental.new(thomas, 7))
  sarah.add_rental(Rental.new(batman, 5))
  sarah.add_rental(Rental.new(thomas, 2))

  context 'when renting movies' do
    it 'Bob gets a statement' do
      expect(bob.statement).to eq("Rental Record for Bob\n\tBatman\t3.5\n\tDune\t9\nAmount owed is 12.5\nYou earned 3 frequent renter points")
    end
    it 'Henry gets a statement' do
      expect(henry.statement).to eq("Rental Record for Henry\n\tBatman\t2\n\tDune\t3\n\tThomas\t7.5\nAmount owed is 12.5\nYou earned 3 frequent renter points")
    end
    it 'Sarah gets a statement' do
      expect(sarah.statement).to eq("Rental Record for Sarah\n\tBatman\t6.5\n\tThomas\t1.5\nAmount owed is 8.0\nYou earned 2 frequent renter points")
    end
  end
end

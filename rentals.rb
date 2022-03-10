# frozen_string_literal: true

# Movie class
class Movie
  REGULAR = 0
  NEW_RELEASE = 1
  CHILDRENS = 2

  attr_accessor :title
  attr_writer :price

  def initialize(title, price)
    @title = title
    @price = price
  end

  def frequent_renter_points(days_rented)
    @price.frequent_renter_points(days_rented)
  end

  def charge(days_rented)
    @price.charge(days_rented)
  end
end

# Rental class
class Rental
  attr_reader :movie, :days_rented

  def initialize(movie, days_rented)
    @movie = movie
    @days_rented = days_rented
  end

  def charge
    movie.charge(days_rented)
  end

  def frequent_renter_points
    movie.frequent_renter_points(days_rented)
  end
end

# Customer class
class Customer
  attr_reader :name

  def initialize(name)
    @name = name
    @rentals = []
  end

  def add_rental(arg)
    @rentals << arg
  end

  def statement
    result = "Rental Record for #{@name}\n"
    @rentals.each do |rental|
      # show figures for this rental
      result += "\t#{rental.movie.title}\t#{rental.charge}\n"
    end
    # add footer lines
    result += "Amount owed is #{total_charge}\n"
    result += "You earned #{total_frequent_renter_points} frequent renter points"
    result
  end

  def html_statement
    result = "<h1>Rental Record for <em>#{@name}</em></h1>\n"
    @rentals.each do |rental|
      # show figures for this rental
      result += "\t#{rental.movie.title}\t#{rental.charge}<br>\n"
    end
    # add footer lines
    result += "<p>Amount owed is <em>#{total_charge}</em></p>\n"
    result += "<p>You earned <em>#{total_frequent_renter_points}</em> frequent renter points.</p>"
    result
  end

  def total_charge
    @rentals.inject(0) { |sum, rental| sum + rental.charge }
  end

  def total_frequent_renter_points
    @rentals.inject(0) { |sum, rental| sum + rental.frequent_renter_points }
  end
end

# module DefaultPrice
module DefaultPrice
  def frequent_renter_points(_days_rented)
    1
  end
end

# class RegularPrice
class RegularPrice
  include DefaultPrice

  def charge(days_rented)
    result = 2
    result += (days_rented - 2) * 1.5 if days_rented > 2
    result
  end
end

# class NewReleasePrice
class NewReleasePrice
  def charge(days_rented)
    days_rented * 3
  end

  def frequent_renter_points(days_rented)
    days_rented > 1 ? 2 : 1
  end
end

# class ChildrensPrice
class ChildrensPrice
  include DefaultPrice

  def charge(days_rented)
    result = 1.5
    result += (days_rented - 3) * 1.5 if days_rented > 3
    result
  end
end

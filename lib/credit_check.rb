require 'pry'
class CreditCheck
attr_reader :card_number, :valid, :index_numbers, :cleaned, :total, :summed
  def initialize(card_number = "4929735477250543")
    @card_number = card_number
    @valid = false
    @index_numbers = Hash.new
    @cleaned = Array.new
    @total = 0
    @summed = Array.new
  end

  def prepare_card
    card_number.chars.each_with_index do |num, index|
      index_numbers[index] = num.to_i
    end
    index_numbers
  end

  def multiply_every_other_number
    index_numbers.each do |key, value|
      @cleaned << value * 2 if key.even?
      @cleaned << value if key.odd?
    end
    cleaned
  end

  def sum_digits_greater_than_nine
    @summed = cleaned.map do |num|
      if num > 9
        num.to_s[0].to_i + num.to_s[1].to_i
      else
        num
      end
    end
  end

  def sum_of_digits
    summed.each do |num|
      @total += num
    end
    total
  end

  def valid?
    @valid = true if total % 10 == 0
    if valid == true
      "The number is valid!"
    else
      "The number is invalid!"
    end
  end
end


# from the rightmost digit moving left =>  array.reverse
# double the value of every other digit => array.each {|num| num.even?} * 2
# if product of doubling > 9 , take sum of digits => num[0] + num[1]
# (sum of digits): total % 10 == 0 it is valid

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
      cleaned << value * 2 if key.even?
      cleaned << value if key.odd?
    end
    cleaned
  end

  def sum_digits_greater_than_nine
    @summed = cleaned.map do |num|
      if num > 9
        num - 9
      else
        num
      end
    end
  end

  def total_sum_of_digits
    @total = summed.reduce(:+)
  end

  def valid?
    valid = true if (total % 10).zero?
    if valid == true
      "The number is valid!"
    else
      "The number is invalid!"
    end
  end
end

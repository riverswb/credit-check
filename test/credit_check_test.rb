require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_check'


class CreditCheckTest < Minitest::Test

  def test_has_a_credit_card_number
    credit = CreditCheck.new

    assert_equal "4929735477250543", credit.card_number
  end

  def test_can_reverse_and_to_integer_card_number
    credit = CreditCheck.new
    prepared = {0=>4, 1=>9, 2=>2, 3=>9, 4=>7, 5=>3, 6=>5, 7=>4, 8=>7, 9=>7, 10=>2, 11=>5, 12=>0, 13=>5, 14=>4, 15=>3}
    assert_equal prepared, credit.prepare_card
  end

  def test_can_multiply_every_other_digit_of_card
    credit = CreditCheck.new
    credit.prepare_card

    assert_equal [8, 9, 4, 9, 14, 3, 10, 4, 14, 7, 4, 5, 0, 5, 8, 3], credit.multiply_every_other_number
  end

  def test_can_sum_the_cleaned_digits
    credit = CreditCheck.new
    credit.prepare_card
    credit.multiply_every_other_number
    credit.sum_digits_greater_than_nine

    assert_equal 80, credit.sum_of_digits
  end

  def test_default_card_is_valid
    credit = CreditCheck.new
    credit.prepare_card
    credit.multiply_every_other_number
    credit.sum_digits_greater_than_nine
    credit.sum_of_digits

    assert credit.valid?
  end

  def test_not_all_cards_are_valid
    credit = CreditCheck.new("79927398888")
    credit.prepare_card
    credit.multiply_every_other_number
    credit.sum_digits_greater_than_nine
    credit.sum_of_digits

    assert_equal "The number is invalid!", credit.valid?
  end

  def test_multiple_valid_numbers
    credit1 = CreditCheck.new("5541808923795240")
    credit1.prepare_card
    credit1.multiply_every_other_number
    credit1.sum_digits_greater_than_nine
    credit1.sum_of_digits

    credit2 = CreditCheck.new("4024007136512380")
    credit2.prepare_card
    credit2.multiply_every_other_number
    credit2.sum_digits_greater_than_nine
    credit2.sum_of_digits

    credit3 = CreditCheck.new("6011797668867828")
    credit3.prepare_card
    credit3.multiply_every_other_number
    credit3.sum_digits_greater_than_nine
    credit3.sum_of_digits

    assert credit1.valid?
    assert credit2.valid?
    assert credit3.valid?
  end

  def test_output_if_valid
    credit = CreditCheck.new("5541808923795240")
    credit.prepare_card
    credit.multiply_every_other_number
    credit.sum_digits_greater_than_nine
    credit.sum_of_digits

    assert_equal "The number is valid!", credit.valid?
  end

  # def test_it_can_verify_amex_cards
  #   credit = CreditCheck.new("342804633855673")
  #   credit.prepare_card
  #   credit.multiply_every_other_number
  #   credit.sum_digits_greater_than_nine
  #   credit.sum_of_digits
  #
  #   assert credit.valid?
  # end
end
# valid: 342804633855673 = 67 digit[0]/2 + digit[1] => total % 10 == 0
# invalid: 342801633855673 = 64

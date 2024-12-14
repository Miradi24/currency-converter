require "application_system_test_case"

class CurrencyConversionsTest < ApplicationSystemTestCase
  setup do
    @currency_conversion = currency_conversions(:one)
  end

  test "visiting the index" do
    visit currency_conversions_url
    assert_selector "h1", text: "Currency conversions"
  end

  test "should create currency conversion" do
    visit currency_conversions_url
    click_on "New currency conversion"

    fill_in "Amount", with: @currency_conversion.amount
    fill_in "Conversion amount", with: @currency_conversion.conversion_amount
    fill_in "From", with: @currency_conversion.from
    fill_in "To", with: @currency_conversion.to
    click_on "Create Currency conversion"

    assert_text "Currency conversion was successfully created"
    click_on "Back"
  end

  test "should update Currency conversion" do
    visit currency_conversion_url(@currency_conversion)
    click_on "Edit this currency conversion", match: :first

    fill_in "Amount", with: @currency_conversion.amount
    fill_in "Conversion amount", with: @currency_conversion.conversion_amount
    fill_in "From", with: @currency_conversion.from
    fill_in "To", with: @currency_conversion.to
    click_on "Update Currency conversion"

    assert_text "Currency conversion was successfully updated"
    click_on "Back"
  end

  test "should destroy Currency conversion" do
    visit currency_conversion_url(@currency_conversion)
    click_on "Destroy this currency conversion", match: :first

    assert_text "Currency conversion was successfully destroyed"
  end
end

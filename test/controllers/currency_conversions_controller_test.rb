require "test_helper"

class CurrencyConversionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @currency_conversion = currency_conversions(:one)
  end

  test "should get index" do
    get currency_conversions_url
    assert_response :success
  end

  test "should get new" do
    get new_currency_conversion_url
    assert_response :success
    # Check that @currencies is set correctly
    assert_not_nil :currencies
  end

  test "should create currency_conversion" do
    assert_difference("CurrencyConversion.count") do
      post currency_conversions_url, params: { currency_conversion: { amount: @currency_conversion.amount, conversion_amount: @currency_conversion.conversion_amount, from: @currency_conversion.from, to: @currency_conversion.to } }
    end

    assert_redirected_to currency_conversion_url(CurrencyConversion.last)
  end

  test "should show currency_conversion" do
    get currency_conversion_url(@currency_conversion)
    assert_response :success
  end

  test "should get edit" do
    get edit_currency_conversion_url(@currency_conversion)
    assert_response :success
    # Check that template variables are set
    assert_not_nil :currencies
    assert_not_nil :@selected_from_currency
    assert_not_nil :@selected_to_currency
  end

  test "should update currency_conversion" do
    patch currency_conversion_url(@currency_conversion), params: { currency_conversion: { amount: @currency_conversion.amount, conversion_amount: @currency_conversion.conversion_amount, from: @currency_conversion.from, to: @currency_conversion.to } }
    assert_redirected_to currency_conversion_url(@currency_conversion)
  end

  test "should destroy currency_conversion" do
    assert_difference("CurrencyConversion.count", -1) do
      delete currency_conversion_url(@currency_conversion)
    end

    assert_redirected_to currency_conversions_url
  end

  test "should use API to calculate conversion during create" do
  post currency_conversions_url, params: {
  # Example form input
  currency_conversion: {
      amount: 100,
      from: "USD",
      to: "EUR"
    }
  }

  # Check that a new conversion is created
  conversion = CurrencyConversion.last
  assert_not_nil conversion
  assert_equal 100, conversion.amount
  assert_equal "USD", conversion.from
  assert_equal "EUR", conversion.to
  assert_equal 95.27, conversion.conversion_amount
end

test "should use API to calculate conversion during update" do
  post currency_conversions_url, params: {
  # Example form input
  currency_conversion: {
      amount: 100,
      from: "USD",
      to: "EUR"
    }
  }

  # Check that a new conversion is created
  conversion = CurrencyConversion.last
  assert_not_nil conversion
  assert_equal 100, conversion.amount
  assert_equal "USD", conversion.from
  assert_equal "EUR", conversion.to
  assert_equal 95.27, conversion.conversion_amount

  # Update conversion
  post currency_conversions_url, params: {
    currency_conversion: {
      amount: 10,
      from: conversion.from,
      to: conversion.to
    }
  }

  latest_conversion = CurrencyConversion.last
  # Check that another api call was made for update
  assert_equal 9.527, latest_conversion.conversion_amount
end
end

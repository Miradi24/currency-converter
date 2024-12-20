require_dependency "currency_converter"

class CurrencyConversionsController < ApplicationController
  include CurrencyConverter
  before_action :set_currency_conversion, only: %i[ show edit update destroy ]

  # GET /currency_conversions or /currency_conversions.json
  def index
    @currency_conversions = CurrencyConversion.all
    @currency_conversion = CurrencyConversion.new
    @currencies = get_currencies
  end

  # GET /currency_conversions/all
  def all
    @currency_conversions = CurrencyConversion.all
  end

  # GET /currency_conversions/1 or /currency_conversions/1.json
  def show
  end

  # GET /currency_conversions/new
  def new
    @currency_conversion = CurrencyConversion.new
    @currencies = get_currencies
  end

  # GET /currency_conversions/1/edit
  def edit
     @currencies = get_currencies
     @selected_from_currency = @currency_conversion.from
     @selected_to_currency = @currency_conversion.to
  end

  # POST /currency_conversions or /currency_conversions.json
  def create
    # Calculate conversion amount
    conversion_amount = convert(currency_conversion_params[:amount], currency_conversion_params[:from], currency_conversion_params[:to])

    @currency_conversion = CurrencyConversion.new(currency_conversion_params)
    @currency_conversion.conversion_amount = conversion_amount

    respond_to do |format|
      if @currency_conversion.save
        format.html { redirect_to @currency_conversion, notice: "Currency conversion was successfully created." }
        format.json { render :show, status: :created, location: @currency_conversion }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @currency_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /currency_conversions/1 or /currency_conversions/1.json
  def update
    conversion_amount = convert(currency_conversion_params[:amount], currency_conversion_params[:from], currency_conversion_params[:to])
    respond_to do |format|
      if @currency_conversion.update(currency_conversion_params.merge(conversion_amount: conversion_amount))
        format.html { redirect_to @currency_conversion, notice: "Currency conversion was successfully updated." }
        format.json { render :show, status: :ok, location: @currency_conversion }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @currency_conversion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /currency_conversions/1 or /currency_conversions/1.json
  def destroy
    @currency_conversion.destroy!

    respond_to do |format|
      format.html { redirect_to currency_conversions_path, status: :see_other, notice: "Currency conversion was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency_conversion
      @currency_conversion = CurrencyConversion.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def currency_conversion_params
      params.expect(currency_conversion: [ :amount, :from, :to, :conversion_amount ])
    end
end

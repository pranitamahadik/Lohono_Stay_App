class VillaController < ApplicationController
  before_action :validate_params, only: [:fetch_villas_details, :calculate_total_rate]
  before_action :find_villa_list, only: [:fetch_villas_details, :calculate_total_rate]

  def fetch_villas_details
    villa_list = get_modified_data
    render json: { data: { list: villa_list, status: 'success'}}, status: :ok
  end

  def calculate_total_rate
    @total_rate_flag = true
    villa_data = get_modified_data
    render json: { data: { list: villa_data, status: 'success'}}, status: :ok
  end

  private
  def validate_params
    render json: { data: { status: 'error', message: 'Start and end date required' }}, status: :unprocessable_entity if params[:start_date].blank? && params[:end_date].blank?
    render json: { data: { status: 'error', message: 'Invalid date' }}, status: :unprocessable_entity unless parsable?(params[:start_date]) && parsable?(params[:end_date])
  end

  def parsable?(date)
    begin
      Date.parse(date)
      true
    rescue Exception => e
      false
    end
  end

  def find_villa_list
    @villa_data = Villa.includes(:calender).where(calender: {start_date: Date.parse(params[:start_date]), end_date: Date.parse(params[:end_date])})
    render json: { data: { status: 'error', message: 'Villas not available' }}, status: :unprocessable_entity if @villa_data.empty?
  end

  def get_modified_data
    list = []
    @villa_data.each do |villa|
      calender_r = villa.calender
      diff_in_days = (calender_r.end_date - calender_r.start_date).to_i
      data_hash = {}
      data_hash[:name] = villa.name
      if @total_rate_flag == true
        data_hash[:total_rate] = total_rate(calender_r, diff_in_days)
      else
        data_hash[:average_price] = calculate_price(calender_r, diff_in_days)
      end
      data_hash[:availability] = {to: calender_r.start_date, from: calender_r.end_date}
      list << data_hash
    end
    list
  end

  def calculate_price(calender, days)
    calender.rate_per_night * days
  end

  def total_rate(calender, days)
    amount = calender.rate_per_night * days
    total_rate = (amount * 18)/100
  end

end

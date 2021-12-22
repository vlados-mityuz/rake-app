class TimeFormatter

  DESIGNATION = {'year'=> '%Y', 'month'=> '%m', 'day'=> '%d', 'hour'=> '%H', 'minute'=> '%m', 'second'=> '%S'}

  attr_reader :params

  def initialize(params)
    @params = params.split(',')
    @format_errors = []
    @valid_params = []
  end

  def call
    @params.each do |param|
     DESIGNATION.key?(param) ? @valid_params << DESIGNATION[param] : @format_errors << param
    end
  end

  def success?
    @format_errors.empty?
  end

  def time_by_pattern
    Time.now.strftime(@valid_params.join('-'))
  end

  def format_error
    @format_errors
  end
end
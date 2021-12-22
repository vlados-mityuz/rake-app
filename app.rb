require_relative 'time_formatter'

class App

  def call(env)
    create_response(env)
  end

  private

  def create_response(env)
    request = Rack::Request.new(env)

    path = request.path
    request_params = request.params['format']

    if path != '/time'
      return response(404, ["404\n"])
    end

    create_formatter(request_params)
  end

  def create_formatter(request_params)
    formatter = Timeformatter.new(request_params)
    formatter.call
    response(400,"Unknown format #{formatter.format_error}") unless formatter.success?
    response(200, "#{formatter.time_by_pattern}" ) if formatter.success?
  end

  def response(status, body)
    Rack::Response.new([body], status, { 'Content-Type' => 'text/plain' }).finish
  end
  
end
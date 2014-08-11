module RequestsHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def active_record_to_json(record)
    ActiveSupport::JSON.decode(record.to_json)
  end

  def set_http_auth(auth_string)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(auth_string)
  end
end
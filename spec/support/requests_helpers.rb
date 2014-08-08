module RequestsHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def active_record_to_json(record)
    ActiveSupport::JSON.decode(record.to_json)
  end
end
module ResponseHelper
  def format_response data = {}
    {code: 200, data: data}
  end

  def format_response_error errors = {message: Settings.errors.something_went_wrong}
    {code: 400, errors: errors}
  end
end

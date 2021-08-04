class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_not_found_response(exception)
    render json: { errors: [ { "code": 404, "message": exception.message }]}, status: :not_found
  end
end

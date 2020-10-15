class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  def error_message(johan)
    error_message = johan.full_messages.to_sentence
    render json: { message: error_message }, status: 422
  end
end

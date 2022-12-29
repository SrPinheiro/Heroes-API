module Authenticable
  private

  def authenticable_with_token
    @token ||= request.headers['Authorization']

    unless valid_token?
      render json: {erros: "Você não possui authorização para executar esta ação"}, status: :unauthorized
    end
  end

  def valid_token?
    @token.present? && @token == Rails.application.credentials.token
  end
end

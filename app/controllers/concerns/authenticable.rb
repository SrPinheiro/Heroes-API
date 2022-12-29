module Authenticable
  private

  def authenticable_with_token
    @token ||= request.headers['Authorization']

    unless valid_token?
      render json: {erros: "Token invalido!"}, status: :unauthorized
    end
  end

  def get_Token
    @token ||= request.headers['Authorization']

  end

  def valid_token?
    @token.present? && @token.size >= 10
  end
end

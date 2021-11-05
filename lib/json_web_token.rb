class JsonWebToken
  def self.encode payload
    JWT.encode payload, ENV['SECRET_KEY'], ENV['JWT_ALGORITHM']
  end

  def self.decode token
    JWT.decode(token, ENV['SECRET_KEY'], true, algorithm: ENV['JWT_ALGORITHM'])[0]
  rescue JWT::DecodeError
    nil
  end
end

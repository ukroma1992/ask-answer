require 'openssl'

class User < ApplicationRecord
  # Параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions, dependent: :destroy
  has_many :authored_questions, class_name: "Question", foreign_key: "author_id", dependent: :nullify

  validates :email, :username, presence: true
  validates :email, :username, uniqueness: true
  validates :email, format: { with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
  validates :username, format: { with: /^[a-z0-9_-]{3,40}$/, multiline: true, message: "only allows letters, digits and underscore" }	
  validates :username, length: { in: 4..40 }
  validates :background_color, format: { with: /\A#([0-9a-f]{3}){1,2}\z/i }, allow_blank: true

  attr_accessor :password

  validates_presence_of :password, on: :create
  validates_confirmation_of :password

  before_save :encrypt_password
  before_validation :downcase_name, on: [ :create, :update ]
  
  def encrypt_password 
    if self.password.present?
      # Создаем т. н. соль - рандомная строка
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      # Создаем hash пароля - длинная уникальная строка, из которой невозможно восстановить исходный пароль
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  # Служебный метод, преобразующий бинарную строку в 16-ричный формат
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password) 
    user = find_by(email: email) # Находим по email

    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user 
    else
      nil
    end
  end

  private

  def downcase_name
    self.username = username.downcase
  end
end

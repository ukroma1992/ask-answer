class Question < ApplicationRecord
  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: { in: 4..255 }
  validates :background_color, format: { with: /\A#([0-9a-f]{3}){1,2}\z/i }
end

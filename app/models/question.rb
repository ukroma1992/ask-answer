class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: "User", foreign_key: "author_id", optional: true

  validates :text, :user, presence: true
  validates :text, length: { in: 4..255 }
  
end

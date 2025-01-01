class Store < ApplicationRecord
  belongs_to :user
  has_many :ratings, dependent: :destroy

  validates :name, presence: true, length: { in: 20..60 }
  validates :address, length: { maximum: 400 }

  scope :search, ->(query) {
    joins(:user).where(
      "stores.name ILIKE :query OR users.email ILIKE :query OR stores.address ILIKE :query",
      query: "%#{query}%"
    )
  }

end

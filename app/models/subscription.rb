class Subscription < ApplicationRecord
  belongs_to :tea
  belongs_to :customer

  validates :customer_id, presence: true
  validates :tea_id, presence: true
  validates :price, presence: true

  enum status: {
    active: 0,
    cancelled: 1
  }

  enum frequency: {
    weekly: 0,
    monthly: 1,
    quarterly: 2
  }
end

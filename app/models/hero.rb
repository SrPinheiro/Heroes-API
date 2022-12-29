class Hero < ApplicationRecord
  validates :name, :token, presence: true

  scope :sorted_by_name, -> {order(:name)}

  scope :by_token, -> (token) {where(token: token)}

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term}%") if term.present?}
end

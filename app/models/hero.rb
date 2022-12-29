class Hero < ApplicationRecord
  validates :name, presence: true

  scope :sorted_by_name, -> {order(:name)}

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term}%") if term.present?}
end

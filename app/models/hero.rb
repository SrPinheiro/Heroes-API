class Hero < ApplicationRecord
  validates :name, :token, presence: true
  validates :name, uniqueness: {scope: :token, case_sensitive: false}

  scope :sorted_by_name, -> {order(:name)}

  scope :by_token, -> (token) {where(token: token)}

  scope :search, -> (term) { where('LOWER(name) LIKE ?', "%#{term}%") if term.present?}

end

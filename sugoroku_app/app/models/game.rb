class Game < ApplicationRecord
  has_many :squares, dependent: :destroy
  has_many :players, dependent: :destroy
end

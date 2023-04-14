class Artist < ApplicationRecord
  validates :name, presence: true
  validates :birth_date, presence: true, unless: -> { death_date.blank? }

  validates :birth_date, comparison: { less_than: :death_date }, allow_blank: true

  validate :birth_date_cant_be_in_the_future
  
  def birth_date_cant_be_in_the_future
    return unless birth_date.present? && birth_date > Time.zone.today

    errors.add(:birth_date, "can't be in the future")
  end


end 


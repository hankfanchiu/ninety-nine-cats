class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: STATUSES }
  validate :new_request_does_not_overlap

  belongs_to :cat

  def approve!
    transaction do
      self.update(status: 'APPROVED')
      overlapping_pending_requests.each do |overlap|
        overlap.update(status: 'DENIED')
      end
    end
  end

  def deny!
    self.update(status: 'DENIED')
  end

  private
  def overlapping_requests
    dates = { start_date: self.start_date, end_date: self.end_date }
    same_cat = self.class.where(cat_id: self.cat_id)
    overlap = same_cat.where(<<-SQL, dates)
      (start_date BETWEEN :start_date AND :end_date)
      OR (end_date BETWEEN :start_date AND :end_date)
    SQL
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def new_request_does_not_overlap
    unless overlapping_approved_requests.empty?
      errors[:new_request] << "overlaps with an approved request."
    end
  end
end

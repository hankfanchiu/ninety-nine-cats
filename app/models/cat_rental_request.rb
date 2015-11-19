class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :user_id, presence: true
  validates :status, inclusion: STATUSES
  validate :request_does_not_overlap_with_approved
  validate :start_date_comes_before_end_date

  belongs_to :cat

  belongs :requester,
    class_name: "User",
    foreign_key: :user_id

  def approve!
    transaction do
      overlapping_pending_requests.update_all(status: 'DENIED')
      self.update(status: 'APPROVED')
    end
  end

  def approved?
    self.status == "APPROVED"
  end

  def deny!
    self.update(status: 'DENIED')
  end

  def denied?
    self.status == "DENIED"
  end

  def pending?
    self.status == "PENDING"
  end

  private
  def overlapping_requests
    self.class
      .where("(:id IS NULL) OR (id != :id)", id: self.id)
      .where(cat_id: self.cat_id)
      .where.not(<<-SQL, start_date: self.start_date, end_date: self.end_date)
        (start_date > :end_date) OR (end_date < :start_date)
      SQL
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def request_does_not_overlap_with_approved
    return if self.denied?

    unless overlapping_approved_requests.empty?
      errors[:request] << "has time overlap with an approved request"
    end
  end

  def start_date_comes_before_end_date
    return if self.start_date < self.end_date
    errors[:start_date] << "must come before end date"
    errors[:end_date] << "must come after start date"
  end
end

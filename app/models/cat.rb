class Cat < ActiveRecord::Base
  COLORS = {
    "R" => "Red",
    "O" => "Orange",
    "Y" => "Yellow",
    "G" => "Green",
    "B" => "Blue",
    "I" => "Indigo",
    "V" => "Violet"
  }

  SEXES = { "M" => "Male", "F" => "Female" }

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: SEXES.keys
  validates :color, inclusion: COLORS.keys
  validate :birth_date_not_in_future

  belongs_to :owner,
    class_name: "User",
    foreign_key: :user_id

  has_many :cat_rental_requests, dependent: :destroy

  def age
    now = Date.today
    now.year - Date.parse(birth_date).year
  end

  def sorted_requests
    cat_rental_requests.order(:start_date)
  end

  private
  def birth_date_not_in_future
    if !birth_date.empty? && (Date.parse(birth_date) > Date.today)
      errors[:birth_date_range] << "is not valid."
    end
  end
end

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

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w(M F) }
  validates :color, inclusion: { in: COLORS.keys }
  validate :birth_date_not_in_future

  has_many :cat_rental_requests, dependent: :destroy

  def age
    now = Date.today
    years = now.year - Date.parse(birth_date).year
    years
  end

  def sorted_requests
    cat_rental_requests.order(:start_date)
  end

  def display_sex
    sex == "M" ? "Male" : "Female"
  end

  def display_color
    COLORS[color]
  end

  private
  def birth_date_not_in_future
    if !birth_date.empty? && (Date.parse(birth_date) > Date.today)
      errors[:birth_date_range] << "is not valid."
    end
  end
end

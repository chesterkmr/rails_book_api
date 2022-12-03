class Book
  include Mongoid::Document
  include Mongoid::Timestamps

  include Filterable


  field :id, type: String
  def id
    self[:_id].to_s
  end

  field :name, type: String
  field :pages, type: Integer

  validates :name, presence: true, length: {minimum:3, maximum: 100}
  validates :pages, presence: true
  validates_uniqueness_of :name

  scope :search_by_name, -> (name) {
    self.where("name like ?", "Book%")
  }
end

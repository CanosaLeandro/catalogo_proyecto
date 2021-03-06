# frozen_string_literal: true

class Product < ApplicationRecord
  # -- Relations
  belongs_to :category
  has_many :product_tags
  has_many :tags, through: :product_tags
  has_many :product_images, dependent: :destroy
  accepts_nested_attributes_for :product_images, allow_destroy: true
  has_many :items

  # -- Validations
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  validates :code, presence: true, uniqueness: true
  validates :category, presence: true
  validates :price,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
  validates :cost,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0
            }
  validate :only_one_image_checked

  before_destroy :check_buys



  # -- Scopes
  scope :with_name, ->(name) { where('name LIKE ?', "%#{name}%") }
  scope :with_category, ->(category_id) { where(category_id: category_id) }
  # scope :sort_asc_name,->{ order(name: :asc) }
  # scope :sort_desc_name, ->{ order(name: :desc) }
  scope :sort_name, ->(sort) { order(name: sort) }
  scope :actives, -> { where(active: true) }
  def only_one_image_checked
    return if product_images.select(&:principal).count == 1

    errors.add(:product_images, message: I18n.t(:only_one_image_error))
  end
  private 

  def check_buys
    return if self.items.count.zero?

    errors.add(:base, I18n.t(:destroy_products_error))
    throw(:abort)
  end
end

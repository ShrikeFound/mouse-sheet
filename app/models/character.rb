class Character < ApplicationRecord
  belongs_to :user
  belongs_to :city, optional: true
  belongs_to :rank, optional: true
  
  has_many :wisdoms, dependent: :destroy
  has_many :wises, through: :wisdoms
  has_many :advancements, dependent: :destroy
  has_many :skills, through: :advancements
  has_many :trait_advancements, dependent: :destroy
  has_many :traits, through: :trait_advancements
  has_many :items, dependent: :destroy
  has_many :contacts, dependent: :destroy

  has_attached_file :image, styles: {medium: "300x300>", thumb: "120x120>"}, dependent: destroy
  validates :image, :content_type: [:jpg,:jpeg,:png]
end

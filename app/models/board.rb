class Board < ApplicationRecord
  belongs_to :user, optional: true

  extend FriendlyId
  friendly_id :title, use: :slugged

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize.to_s
  end  

  include AASM

  aasm(column: 'state', no_direct_assignment: true) do
    state :open, initial: true
    state :hidden, :locked

    event :hide do
      transitions from: :open, to: :hidden
      # 在狀況改變的時後，可以設定發簡訊
      after do
        puts "發簡訊！！"
      end
    end
    
    event :lock do
      transitions from: :open, to: :locked
    end

    event :open do
      transitions from: [:locked, :hidden], to: :open
    end
  end

  def owned_by?(user)
    self.user == user
  end
end

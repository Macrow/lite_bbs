require 'will_paginate/active_record'

module LiteBbs
  class Topic < ActiveRecord::Base
    attr_accessible :content, :title, :forum_id, :can_reply, :stick
    has_many :replies, dependent: :destroy, order: 'created_at'
    belongs_to :section, counter_cache: true
    belongs_to :forum, counter_cache: true
    belongs_to :user, class_name: LiteBbs.user_class, foreign_key: 'user_id'
    has_one :last_reply, class_name: 'Reply', foreign_key: 'topic_id', order: 'created_at DESC'
    validates_length_of :title, in: 1..80
    validates_length_of :content, in: 10..4096
    after_create :update_order_at
    scope :stick, where('stick_at IS NOT NULL')
    scope :seal, where(:can_reply => false)
    
    self.per_page = LiteBbs.topics_per_page
    
    def stick
      stick_at.nil? ? false : true
    end
    
    def stick=(value)
      if value == '1' or value == 1 or value == true
        self.stick_at = Time.zone.now
      else
        self.stick_at = nil
      end
    end
    
    def view_once
      update_column(:view_count, view_count + 1)
    end
    
    def reply_once
      update_column(:floor_count, floor_count + 1)
    end    
    
    def update_order_at(datetime = nil)
      datetime = created_at if datetime.nil?
      update_column(:order_at, datetime)
    end
    
    def toggle_stick
      update_column(:stick_at, (stick_at.nil? ? Time.zone.now : nil))
    end    
  end
end

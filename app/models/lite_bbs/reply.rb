require 'will_paginate/active_record'

module LiteBbs
  class Reply < ActiveRecord::Base
    attr_accessible :content
    belongs_to :forum, counter_cache: true
    belongs_to :topic, counter_cache: true
    belongs_to :user, class_name: LiteBbs.user_class, foreign_key: 'user_id'
    validates_length_of :content, in: 10..4096
    after_create :update_topic_info
    before_destroy :update_topic_order_at_from_last_reply
    
    self.per_page = LiteBbs.replies_per_page

    def update_topic_info
      topic = self.topic
      topic.update_order_at(created_at)
      topic.reply_once
    end
    
    def update_topic_order_at_from_last_reply
      if self == self.topic.last_reply
        new_order_at = self.topic.last_reply ? self.topic.last_reply.created_at : nil
        self.topic.update_order_at(new_order_at)
      end
    end
  end
end

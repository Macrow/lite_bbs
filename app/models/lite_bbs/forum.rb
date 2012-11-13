module LiteBbs
  class Forum < ActiveRecord::Base
    attr_accessible :description, :name, :orders, :section_id
    has_many :topics, dependent: :destroy
    has_many :topics, order: 'order_at DESC'
    has_many :normal_topics, class_name: 'Topic', order: 'order_at DESC', conditions: {:stick_at => nil}
    has_many :stick_topics, class_name: 'Topic', order: 'stick_at DESC', conditions: 'stick_at IS NOT NULL'
    has_many :replies, dependent: :destroy
    has_one :last_topic, class_name: 'Topic', foreign_key: 'forum_id', order: 'created_at DESC'
    belongs_to :section, counter_cache: true
    validates_length_of :name, in: 1..50
    validates_length_of :description, in: 0..100    
    default_scope order(:orders)
    
    def self.update_orders(ids, orders)
      ids.each_with_index {|id, index| update(id, orders: orders[index])}
    end    
  end
end

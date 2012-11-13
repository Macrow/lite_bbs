module LiteBbs
  class Section < ActiveRecord::Base
    attr_accessible :description, :name, :orders
    has_many :forums, dependent: :destroy
    has_many :topics, dependent: :destroy
    validates_length_of :name, in: 1..50
    validates_length_of :description, in: 0..100
    default_scope order(:orders)
    
    def self.update_orders(ids, orders)
      ids.each_with_index {|id, index| update(id, orders: orders[index])}
    end    
  end
end

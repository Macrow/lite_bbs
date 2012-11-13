class CreateLiteBbsTables < ActiveRecord::Migration
  def self.up
    create_table :lite_bbs_sections do |t|
      t.string :name
      t.string :description
      t.integer :forums_count, default: 0
      t.integer :topics_count, default: 0
      t.integer :orders, default: 0
      t.timestamps
    end
    
    create_table :lite_bbs_forums do |t|
      t.string :name
      t.string :description
      t.integer :section_id
      t.integer :topics_count, default: 0
      t.integer :replies_count, default: 0
      t.integer :orders, default: 0
      t.timestamps
    end
    
    create_table :lite_bbs_topics do |t|
      t.string :title
      t.text :content
      t.integer :section_id
      t.integer :forum_id
      t.integer :user_id
      t.integer :replies_count, default: 0
      t.integer :view_count, default: 0
      t.datetime :order_at
      t.datetime :stick_at
      t.boolean :can_reply, default: true
      t.integer :floor_count, default: 0
      t.timestamps
    end
    
    create_table :lite_bbs_replies do |t|
      t.text :content
      t.integer :floor
      t.integer :forum_id
      t.integer :topic_id
      t.integer :user_id
      t.timestamps
    end

    add_index :lite_bbs_sections, :name
    add_index :lite_bbs_forums, :name
    add_index :lite_bbs_forums, :section_id
    add_index :lite_bbs_topics, :title
    add_index :lite_bbs_topics, :section_id
    add_index :lite_bbs_topics, :forum_id
    add_index :lite_bbs_topics, :user_id
    add_index :lite_bbs_replies, :forum_id
    add_index :lite_bbs_replies, :topic_id
    add_index :lite_bbs_replies, :user_id
  end

  def self.down
    drop_table :lite_bbs_replies
    drop_table :lite_bbs_topics
    drop_table :lite_bbs_forums
    drop_table :lite_bbs_sections
  end
end


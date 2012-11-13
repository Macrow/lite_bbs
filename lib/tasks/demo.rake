require 'active_record/fixtures'

namespace :lite_bbs do
  namespace :demo do
    desc "Load demo data"
    task :load => :environment do
      models = %w(Section Forum Topic Reply)
      models.each do |model|
        ActiveRecord::Fixtures.create_fixtures(LiteBbs.root.join('db/demo'), "lite_bbs_#{model.downcase.pluralize}")
      end
      
      print 'Updating'
      LiteBbs::Section.all.each do |section|
        section.forums_count = section.forums.count
        section.topics_count = section.topics.count
        section.save!
        print '.'
      end
      
      LiteBbs::Forum.all.each_with_index do |forum, index|
        forum.topics_count = forum.topics.count
        forum.replies_count = forum.replies.count
        forum.save!
        print '.' if index % 5 == 0
      end
        
      LiteBbs::Topic.all.each_with_index do |topic, index|
        topic.replies_count = topic.replies.count
        topic.floor_count = topic.replies.count
        topic.order_at = topic.last_reply.created_at if topic.last_reply
        topic.save!
        print '.' if index % 10 == 0
        topic.replies.each_with_index do |reply, index|
          reply.floor = index + 1
          reply.save!
        end
      end
      
      topics = LiteBbs::Topic.count
      
      20.times do
        topic = LiteBbs::Topic.find(rand(topics) + 1)
        topic.toggle_stick
      end
      
      20.times do
        topic = LiteBbs::Topic.find(rand(topics) + 1)
        topic.toggle!(:can_reply)
      end
      puts ''
      puts 'Demo datas load successfully !!'
    end
  end
end
require 'spec_helper'

describe LiteBbs::Reply do
  let(:section) { FactoryGirl.create(:section) }
  let(:forum) { FactoryGirl.create(:forum, section_id: section.id) }
  let(:topic) { FactoryGirl.create(:topic, section_id: section.id, forum_id: forum.id) }
  
  it "create a new reply" do
    title = 'new reply title'
    content = 'reply content'
    reply = topic.replies.build
    reply.save.should be_false
    reply.title = title
    reply.content = content
    reply.forum_id = forum.id
    reply.save.should be_true
    reply.title.should == title
    reply.content.should == content
    reply.forum.should == forum
    reply.topic.should == topic
    forum.replies.count.should  == 1
    topic.replies.count.should == 1
  end
end
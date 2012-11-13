require 'spec_helper'

describe LiteBbs::Topic do
  let(:section) { FactoryGirl.create(:section) }
  let(:forum) { FactoryGirl.create(:forum, section_id: section.id) }
  
  it "create a new topic" do
    title = 'new topic title'
    content = 'topic content'
    topic = forum.topics.build
    topic.save.should be_false
    topic.title = title
    topic.content = content
    topic.section_id = section.id
    topic.save.should be_true
    topic.title.should == title
    topic.content.should == content
    topic.forum.should == forum
    topic.section.should == section
    section.topics.count.should  == 1
    forum.topics.count.should == 1
  end
end
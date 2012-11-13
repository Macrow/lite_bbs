require 'spec_helper'

describe LiteBbs::Section do
  it "create a new section" do
    name = 'new section name'
    section = LiteBbs::Section.new
    section.save.should be_false
    section.name = name
    section.save.should be_true
    section.name.should == name
  end
  
  context "models relationship dependent:" do
    before(:each) do
      @section = FactoryGirl.create(:section)
      @forum = FactoryGirl.create(:forum)
      @topic = FactoryGirl.create(:topic)
      @reply = FactoryGirl.create(:reply)
      @section.forums << @forum
      @section.topics << @topic
      @forum.topics << @topic
      @forum.replies << @reply
      @topic.replies << @reply
    end
    
    it "have right relationship" do
      @section.forums.include?(@forum).should be_true
      @section.topics.include?(@topic).should be_true
      @forum.topics.include?(@topic).should be_true
      @forum.replies.include?(@reply).should be_true
      @topic.replies.include?(@reply).should be_true
    end
    
    it "destroy one section" do
      @section.destroy
      @section.forums.should be_empty
      @section.topics.should be_empty
      @forum.topics.should be_empty
      @forum.replies.should be_empty
      @topic.replies.should be_empty
    end
    
    it "destroy one forum" do
      @forum.destroy
      @forum.section.should_not be_nil
      @forum.topics.should be_empty
      @forum.replies.should be_empty
    end
    
    it "destroy one topic" do
      @topic.destroy
      @topic.section.should_not be_nil
      @topic.forum.should_not be_nil
      @topic.replies.should be_empty
    end
    
    it "destroy one reply" do
      @reply.destroy
      @reply.forum.section.should_not be_nil
      @reply.topic.section.should_not be_nil
      @reply.forum.should_not be_nil
      @reply.topic.should_not be_nil
    end
  end
end
require 'spec_helper'

describe LiteBbs::Forum do
  let(:section) { FactoryGirl.create(:section) }
  
  it "create a new forum" do
    name = 'a forum name'
    forum = section.forums.build
    forum.save.should be_false
    forum.name = name
    forum.save.should be_true
    forum.name.should == name
    forum.section.should == section
    section.forums.count.should == 1
  end
end
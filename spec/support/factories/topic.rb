FactoryGirl.define do
  factory :topic, class: LiteBbs::Topic do |f|
    f.title 'lite_bbs topic title'
    f.content 'topic content'
  end
end
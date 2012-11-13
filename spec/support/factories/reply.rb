FactoryGirl.define do
  factory :reply, class: LiteBbs::Reply do |f|
    f.title 'lite_bbs reply title'
    f.content 'reply content'
  end
end
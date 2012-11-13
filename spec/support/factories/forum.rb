FactoryGirl.define do
  factory :forum, class: LiteBbs::Forum do |f|
    f.name 'lite_bbs forum name'
    f.description 'forum description'
  end
end
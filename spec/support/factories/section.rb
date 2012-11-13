FactoryGirl.define do
  factory :section, class: LiteBbs::Section do |f|
    f.name 'lite_bbs section name'
    f.description 'section description'
  end
end
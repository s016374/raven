require 'faker'
require 'factory_bot'

class User
  attr_accessor :name, :email, :title

end

class Post
  attr_accessor :title

end


FactoryBot.define do
  factory :user, aliases: [:author, :commenter] do
    name { Faker::Name.name }
    sequence(:email) { |n| "#{name}_#{n}@example.com".downcase }

    factory :user_post do
      title { Faker::Book.title }
    end

  end

  factory :post do
    # association :author
    title { Faker::Book.title }
  end
end

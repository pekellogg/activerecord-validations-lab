class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }, presence: true
    validates :summary, length: { maximum: 250 }, presence: true
    validates :category, inclusion: { in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category" }, presence: true
    validate :title_non_clickbait

    def title_non_clickbait
        if [/Won't Believe/, /Secret/, /Top [0-9]*/, /Guess/].none? { |clickbait_exp| clickbait_exp.match(title) }
            errors.add(:title, "title is not clickbaity-y")
        end
    end
end

# https://stackoverflow.com/questions/23530762/check-whether-a-string-contains-one-of-multiple-substrings

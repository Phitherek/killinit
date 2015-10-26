class ApiToken < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :token, presence: true, uniqueness: true

    def self.generate_for(user)
        t = ApiToken.new
        t.user = user
        while !t.valid?
            t.token = Forgery(:basic).text(exactly: 30)
        end
        t.save
        t
    end
end

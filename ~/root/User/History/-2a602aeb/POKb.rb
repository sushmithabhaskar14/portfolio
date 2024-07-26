class User < ApplicationRecord
    has_many :attachments, as: :imageable
end

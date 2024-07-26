class User < ApplicationRecord
    has_one :attachments, as: :imageable
end

class Portfolio < ApplicationRecord
    has_many :attachments, as: :imageable
end

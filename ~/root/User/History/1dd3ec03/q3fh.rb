class Project < ApplicationRecord
    has_many :attachments, as: :imageable
end

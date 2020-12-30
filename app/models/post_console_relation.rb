class PostConsoleRelation < ApplicationRecord
  belongs_to :post
  belongs_to :console
end

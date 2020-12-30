class BoardConsoleRelation < ApplicationRecord
  belongs_to :board
  belongs_to :console
end

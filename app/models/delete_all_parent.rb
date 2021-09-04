class DeleteAllParent < ApplicationRecord
  has_many :delete_all_children
end

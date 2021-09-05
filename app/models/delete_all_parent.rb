class DeleteAllParent < ApplicationRecord
  # has_many :delete_all_children
  has_many :delete_all_children, dependent: :destroy
end

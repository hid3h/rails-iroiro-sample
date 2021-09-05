class DeleteAllController < ApplicationController
  def index
    p "ああああです"
    DeleteAllParent.first.delete_all_children.delete_all
  end
end

class Todo < ActiveRecord::Base
  validates :todo_item, presence: true
end

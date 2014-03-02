class AddEmailToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :email, :string
  end
end

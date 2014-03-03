class TodosController < ApplicationController
  # before_action :authenticate_user!

  def index
    if user_signed_in?
  	  @todo_items = Todo.find_all_by_email(current_user.email)
  	  @new_todo = Todo.new
    else
      render "welcome/index"
    end
  end

  def delete
    t = Todo.last
    unless t.nil?
      t.delete
      flash[:success] = "Todo deleted successfully"
    end
    redirect_to :action => 'index'
  end

  def add
    todo = Todo.create(:todo_item => params[:todo][:todo_item], :email => current_user.email)
    if !todo.valid?
      flash[:error] = todo.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end
    redirect_to :action => 'index'
  end

  def complete
    unless params[:todos_checkbox].nil?
      params[:todos_checkbox].each do |check|
        todo_id = check
        t = Todo.find_by_id(todo_id)
        t.update_attribute(:completed, !t.completed)
      end
    end
    redirect_to :action => 'index'
 end
end

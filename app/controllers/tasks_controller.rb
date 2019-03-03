class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :current_user, only: [:destroy]

  def index
    # "/" + get
    @tasks = Task.all.page(params[:page]).per(10)
    #render :index #app/views/tasks/index.html.erb
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      content: params[:content],user_id: @current_user.id
      )
    

    if @task.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が登録されませんでした'
      render :new
    end
  end

  def edit
     @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスク が正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'タスク が正常に更新されませんでした'
      render :edit
    end
  end

  def destroy
        @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end
  
 private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end

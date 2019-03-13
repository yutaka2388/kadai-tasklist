class TasksController < ApplicationController
  before_action :require_user_logged_in

  def index
    # "/" + get
    if logged_in?
      @tasks = current_user.tasks.page(params[:page]).per(10)
    end
    #render :index #app/views/tasks/index.html.erb
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
  @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to root_url
    else
      @tasks = current_user.feed_tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def edit
     @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'タスク が正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'タスク が正常に更新されませんでした'
      render :edit
    end
  end

  def destroy
 @task.destroy
    flash[:success] = 'タスクを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
 private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

end

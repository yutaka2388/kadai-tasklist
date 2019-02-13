class TasklistController < ApplicationController
  def index
    @messages = Message.all
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @message
    else
      flash.now[:danger] = 'タスク が登録されませんでした'
      render :new
    end
  end

  def edit
     @message = Message.find(params[:id])
  end

  def update
    @message = Message.find(params[:id])

    if @message.update(message_params)
      flash[:success] = 'タスク が正常に登録されました'
      redirect_to @message
    else
      flash.now[:danger] = 'タスク が正常に登録されませんでした'
      render :edit
    end
  end

  def destroy
        @message = Message.find(params[:id])
    @message.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to messages_url
  end
  
 private

  # Strong Parameter
  def message_params
    params.require(:message).permit(:content)
  end

end

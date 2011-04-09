class EventsController < ApplicationController

  #------#
  # list #
  #------#
  def list
    @events = Event.paginate( :conditions => "user_id = #{session[:user_id]}", :page => params[:page], :per_page => PER_PAGE, :order => "created_at DESC" )
  end

  #------#
  # show #
  #------#
  def show
    @event = Event.find_by_id( params[:id] )
  end

  #-----#
  # new #
  #-----#
  def new
    @event = Event.new
  end

  #------#
  # edit #
  #------#
  def edit
    @event = Event.find_by_id( params[:id] )
  end

  #--------#
  # create #
  #--------#
  def create
    @event = Event.new( params[:event] )
    @event.user_id = session[:user_id]

    if @event.save
#      flash[:notice] = "イベントの新規作成が完了しました。"
      redirect_to :action => "list" and return
    else
      flash[:notice] = "イベントの新規作成に失敗しました。"
      redirect_to :action => "new" and return
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @event = Event.find_by_id( params[:id] )

    redirect_to :action => "edit" if @event.blank? and return
    
    @event.user_id = session[:user_id]

    if @event.update_attributes( params[:event] )
#      flash[:notice] = "イベントの更新が完了しました。"
      redirect_to :action => "list" and return
    else
      flash[:notice] = "イベントの更新に失敗しました。"
      redirect_to :action => "edit" and return
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @event = Event.find_by_id( params[:id] )

    redirect_to :action => "list" if @event.blank? and return

    if @event.destroy
#      flash[:notice] = "イベントの削除が完了しました。"
    else
      flash[:notice] = "イベントの削除に失敗しました。"
    end

    redirect_to :action => "list" and return
  end
end

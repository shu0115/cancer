class PublicController < ApplicationController

  #------#
  # list #
  #------#
  def list
    @events = Event.paginate( :conditions => { :mode => "public" }, :page => params[:page], :per_page => PER_PAGE, :order => "created_at DESC" )
  end
  
  #-------#
  # table #
  #-------#
  def table
    # イベント
    @event = Event.find_by_id( params[:id] )

    # 予定日
    @schedules = Schedule.all( :conditions => { :event_id => @event.id }, :order => "schedule_day ASC" )
    
    # 参加ユーザ
    @entries = Entry.all( :conditions => { :event_id => @event.id }, :order => "user_id ASC" )

    # ユーザIDでまとめる
    @entry_hash = Hash.new{ | hash, key | hash[key] = Hash.new }
    @entries.each{ |entry|
      @entry_hash[entry.user_id][entry.schedule_day] = entry.attend
    }

    # 参加ユーザのIDリストを取得
    @entry_user = Entry.all( :conditions => { :event_id => @event.id }, :select => "DISTINCT user_id", :order => "user_id ASC" )

    # カウント
    @count_hash = Schedule.attend_count( @event.id)
  end

  #--------------#
  # entry_update #
  #--------------#
  # 参加予定更新(既にある場合は更新、参加予定がない場合は作成)
  def entry_update
    # 参加予定
    @entrys = params[:entry]
    
    # イベントID
    @event = Event.find_by_id_and_mode( params[:id], "public" )

    # 参加予定が空欄でなければ
    unless @entrys.blank?      
      @entrys.each_pair{ |schedule_day, attend|
        # 参加予定を取得
        entry = Entry.find( :first, :conditions => { :event_id => @event.id, :user_id => session[:user_id], :schedule_day => schedule_day } )

        # 既存の参加予定が存在すれば
        unless entry.blank?
          # 参加予定を更新
          if entry.update_attributes( :attend => attend )
            #flash[:notice] = '参加予定を更新しました。'
          else
            flash[:notice] = '参加予定の保存に失敗しました。'
            break
          end
        else
          @user_entry = Entry.new
          @user_entry.schedule_day = schedule_day
          @user_entry.attend = attend
          @user_entry.event_id = @event.id
          @user_entry.user_id = session[:user_id]
          if @user_entry.save
            #flash[:notice] = '参加予定を更新しました。'
          else
            flash[:notice] = '参加予定の保存に失敗しました。'
            break
          end
        end
      }
    end

    redirect_to :action => "entry_table", :id => @event.id and return
  end
  
  #------------#
  # entry_edit #
  #------------#
  def entry_edit
    # イベント
    @event = Event.find_by_id_and_mode( params[:id], "public" )

#    print "[ @event ] : "; p @event ;

    @user_entries = Entry.find( :all, :conditions => { :event_id => @event.id, :user_id => session[:user_id] }, :order => "created_at ASC" )
    @schedules = Schedule.find( :all, :conditions => { :event_id => @event.id }, :order => "schedule_day ASC" )

    @attend_hash = Hash.new
    @user_entries.each{ |entry| @attend_hash[entry.schedule_day] = entry.attend }

    render :layout => false
  end

  #-----------#
  # entry_new #
  #-----------#
  def entry_new
    # イベント
    @event = Event.find_by_id_and_mode( params[:id], "public" )

    @user_entries = Entry.find( :all, :conditions => { :event_id => @event.id, :user_id => session[:user_id] }, :order => "created_at ASC" )
    @schedules = Schedule.find( :all, :conditions => { :event_id => @event.id }, :order => "schedule_day ASC" )

    @attend_hash = Hash.new
    @user_entries.each{ |entry| @attend_hash[entry.schedule_day] = entry.attend }

    render :layout => false
  end

  #-------------#
  # entry_table #
  #-------------#
  def entry_table
    # イベント
    @event = Event.find_by_id_and_mode( params[:id], "public" )
    
    unless @event.blank?
      # 予定日
      @schedules = Schedule.all( :conditions => { :event_id => @event.id }, :order => "schedule_day ASC" )
      
      # 参加ユーザ
      @entries = Entry.all( :conditions => { :event_id => @event.id }, :order => "user_id ASC" )
  
      # ユーザIDでまとめる
      @entry_hash = Hash.new{ | hash, key | hash[key] = Hash.new }  # 二次元ハッシュ
      @entries.each{ |entry|
        @entry_hash[entry.user_id][entry.schedule_day] = entry.attend
      }
  
      # 参加ユーザのIDリストを取得
      @entry_user = Entry.all( :conditions => { :event_id => @event.id }, :select => "DISTINCT user_id", :order => "user_id ASC" )
  
      # 参加率カウント
      @count_hash = Schedule.attend_count( @event.id )

      render :partial => "entry_table" and return
    else
      flash[:notice] = "イベント情報がありません。"
      redirect_to :action => "table", :id => params[:id] and return
    end
  end

end

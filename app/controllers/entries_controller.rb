class EntriesController < ApplicationController

  #------#
  # list #
  #------#
  def list
    @entries = Entry.find( :all )
  end

  #------#
  # show #
  #------#
  def show
    @entry = Entry.find( params[:id] )
  end

  #-----#
  # new #
  #-----#
  def new
    @entry = Entry.new
  end

  #------#
  # edit #
  #------#
  def edit
    @entry = Entry.find( params[:id] )
  end

  #--------#
  # create #
  #--------#
  def create
    @entry = Entry.new( params[:entry] )

    if @entry.save
      flash[:notice] = "参加者の新規作成が完了しました。"
      redirect_to :action => "list"
    else
      flash[:notice] = "参加者の新規作成に失敗しました。"
      redirect_to :action => "new"
    end
  end

  #--------#
  # update #
  #--------#
  def update
    @entry = Entry.find( params[:id] )

    if @entry.update_attributes(params[:entry])
      flash[:notice] = "参加者の更新が完了しました。"
      redirect_to :action => "list"
    else
      flash[:notice] = "参加者の更新に失敗しました。"
      redirect_to :action => "edit"
    end
  end

  #---------#
  # destroy #
  #---------#
  def destroy
    @entry = Entry.find( params[:id] )

    if @entry.destroy
      flash[:notice] = "参加者の削除が完了しました。"
    else
      flash[:notice] = "参加者の削除に失敗しました。"
    end

    redirect_to :action => "list"
  end

end

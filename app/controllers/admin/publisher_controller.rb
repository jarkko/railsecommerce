class Admin::PublisherController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @publisher_pages, @publishers = paginate :publishers, :per_page => 10
  end

  def show
    @publisher = Publisher.find(params[:id])
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new(params[:publisher])
    if @publisher.save
      flash[:notice] = 'Publisher was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @publisher = Publisher.find(params[:id])
  end

  def update
    @publisher = Publisher.find(params[:id])
    if @publisher.update_attributes(params[:publisher])
      flash[:notice] = 'Publisher was successfully updated.'
      redirect_to :action => 'show', :id => @publisher
    else
      render :action => 'edit'
    end
  end

  def destroy
    Publisher.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end

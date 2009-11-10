class ContactsController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :index, :update]
  
  # GET /contacts
  # GET /contacts.xml
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.xml
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.xml
  def new
    @contact = Contact.new
    @contact.subject = "Please contact me to discuss my project"
  end

  # POST /contacts
  # POST /contacts.xml
  def create
    @contact = Contact.new(params[:contact])

    if @contact.save
      ContactMailer.deliver_autoreply(@contact)
      ContactMailer.deliver_notify_webmaster(@contact)
      render 'message_sent'
    else
      render :action => "new" 
    end
  end
  

  # DELETE /contacts/1
  # DELETE /contacts/1.xml
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to(contacts_url) }
      format.xml  { head :ok }
    end
  end
end
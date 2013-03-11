class WelcomeController < ApplicationController
  
  def register
    @user = User.new(params[:user])
    if request.post? and @user.save
      flash[:notice] = "Welcome, #{@user.username}!"
      session[:username], session[:user_id] = @user.username, @user.id
      redirect_to(:controller => 'welcome', :action => 'index')
    end
  end
  
  def login
    if params[:username].blank? || params[:password].blank?
      flash[:notice] = "Please enter both a username and password to login."
      redirect_to(:controller => 'welcome', :action => 'register') and return
    end
    
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id], session[:username] = user.id, user.username
      flash[:notice] = "Logged in as #{user.username}."
      redirect_to(:controller => 'welcome', :action => 'index') and return
    end

    flash[:notice] = "Wrong username or password. Please try again."
    redirect_to(:controller => 'welcome', :action => 'index') and return
  end

  def logout
    session[:user_id], session[:username] = nil, nil    
    flash[:notice] = "Logged off"
    redirect_to(:controller => 'welcome', :action => 'index')
  end
  
  def invite
    if request.post?
      invitation = Doc.create(:text1 => 'invitation / challenge', :text2 => params[:contact_emails], :text3 => params[:message], :text4 => params[:author])        
      GeneralMailer.deliver_contacts('student', @student.username, @student.email, params[:message], params[:contact_emails])
      flash[:notice] = "Challenge accepted!"
      redirect_to(:controller => 'play', :action => 'index')
    else
      @default_message = "I just got from #{params[:start_page]} to #{params[:target_page]} in #{params[:time]} seconds on WikiWarp.com, scoring #{params[:score]} points! Think you can beat my score?"
      @default_author =  session[:username] ? session[:username] : ''
      flash[:notice] = nil
    end
  end
  
  def contact
    if request.post?
      comment = Doc.create(:text1 => 'contact us', :text2 => params[:message], :text3 => params[:author])
      flash[:notice] = "Thanks for the message!"
      redirect_to(:controller => 'welcome', :action => 'index')
    end
  end
end
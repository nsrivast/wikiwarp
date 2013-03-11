require 'hpricot'
require 'open-uri'

class PlayController < ApplicationController
  WIKI_PATH = 'http://en.wikipedia.org/wiki/'
  WIKI_RANDOM_PATH = WIKI_PATH + 'Special:Random'

  # STARTING A GAME
  def featured
    fg = Samplegame.first(:offset => rand(Samplegame.count))
	update_session_variables(fg.id, fg.start, fg.target, -1, '', (Time.now.to_f*10).round/10.0, 'featured')
    redirect_to(:action => 'wiki', :id => session[:start_page], :hash => hash_me(session[:start_page]))    
  end
  
  def random
    random_start = (Hpricot(open(WIKI_RANDOM_PATH))/"title").inner_html[0..-36].gsub(' ','_')
    random_target = (Hpricot(open(WIKI_RANDOM_PATH))/"title").inner_html[0..-36].gsub(' ','_')
    sg = Samplegame.create(:start => random_start, :target => random_target, :author => 9999, :author_type => 3)
    update_session_variables(sg.id, random_start, random_target, -1, '', (Time.now.to_f*10).round/10.0, 'random')    
    redirect_to(:action => 'wiki', :id => session[:start_page], :hash => hash_me(session[:start_page])) 
  end
  
  def custom
    user_start = params[:start_page].gsub(' ','_').downcase
    user_target = params[:target_page].gsub(' ','_').downcase
	[user_start, user_target].each do |page| 
      html = Hpricot(open(WIKI_PATH + page))
      if /Wikipedia does not have an article with this exact name/.match(html.to_html)
        flash[:notice] = "There's no wikipedia page on <br /> en.wikipedia.org/wiki/" + page + " ... maybe you speeled it wrong?."
        redirect_to(:action => 'index') and return
      end
    end
    
    sg = Samplegame.find_by_start_and_target(user_start, user_target)
    sg ||= Samplegame.create(:start => user_start, :target => user_target, :author => session[:user_id] ? session[:user_id] : 1, :author_type => 2)
    update_session_variables(sg.id, user_start, user_target, -1, '', (Time.now.to_f*10).round/10.0, 'custom')    
    redirect_to(:action => 'wiki', :id => session[:start_page], :hash => hash_me(session[:start_page]))
  end
  
  def update_session_variables(id, start, target, num_links, path, start_time, gamertype)
    session[:game_id], session[:start_page], session[:target_page] = id, start, target
	session[:num_links], session[:path], session[:start_time], session[:gamertype] = num_links, path, start_time, gamertype
  end

  # PLAYING A GAME
  def wiki 
    @elapsed_time = ((Time.now.to_f - session[:start_time])*10).round/10
    @curr_page = params[:id]
    @hash_code = params[:hash]
    
    if not hash_me(@curr_page) == @hash_code
      flash[:notice] = "Either you typed in a URL in a blatant attempt to cheat, or there's a bug in our code."
      redirect_to(:action => 'index') and return
    end
    
    # check for win
    if @curr_page.downcase == session[:target_page].downcase
      session[:num_links] = session[:num_links] + 1
      session[:path] += @curr_page + '((' + @elapsed_time.to_s + ')),,'      
	  redirect_to(:action => 'complete') and return
    end

  	filename = "public/cache/" + @curr_page + ".txt"	  
    if Dir.glob(filename) != []
	  @clean_html = Hpricot(File.open(filename, "r").read) 
    else
      @raw_html = Hpricot(open(WIKI_PATH + @curr_page))
      @clean_html = parse_html(@raw_html)
      #File.open(filename, "w"){|f| f.write(@clean_html)}        
    end
	
    # update session information
	session[:start_time] = Time.now.to_f - @elapsed_time	
    @score = compute_score(@elapsed_time)
    session[:num_links] = session[:num_links] + 1
    session[:path] += @curr_page + '((' + @elapsed_time.to_s + ')),,'          
    @curr_page_readable = @curr_page.gsub('_',' ')  
  end
  
  # FINISHING A GAME
  def complete
    @full_path = session[:path][0..-3]
    @elapsed_time = ((Time.now.to_f - session[:start_time])*10).round/10.0
    @score = compute_score(@elapsed_time)
    
    completed_game = Warp.create(
      :user_id => session[:user_id] ? session[:user_id] : 1,
      :samplegame_id => session[:game_id], :links => session[:num_links], :time => @elapsed_time, :score => @score,
      :start => session[:start_page], :target => session[:target_page], :path => @full_path)    
    
    @user = User.find_by_id(session[:user_id]) if session[:user_id]
    if @user
      @user.total_score = @score + (@user.total_score ? @user.total_score : 0)
      @user.save
    end
    
    flash[:notice] = "Finished!"
  end
  
  private
  
  def parse_html(html)
    ["div.dablink", "div.printfooter", "div.catlinks", "//div[@id='jump-to-nav']",
      "//a[@name='External_links']", "//a[@href='http://*']", "//h3[@id='siteSub']", "span.editsection", "table./metadata/",
      "//table[@class='metadata plainlinks ambox ambox-content']", 
	  "//table[@class='metadata plainlinks ombox-small']"].each { |str| html.search(str).remove }
   
    html = (html/"#bodyContent").to_html
    html = html.gsub(/"\/wiki\/[\w()-.]+"/) { |href_link| "wiki?id=" + href_link[7..-2] + "&hash=" + hash_me(href_link[7..-2]) }
    html.html_safe
  end
  
  def hash_me(str)
    Digest::SHA1.hexdigest(str + 'dangraf')[1..10]
  end
  
  def compute_score(time)
    if session[:gamertype] == 'featured'
      score = 2711/(time+20)**0.4
    else
      score = 5022/(time+50)**0.3
    end
	score.round
  end  
end

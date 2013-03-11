class AdminController < ApplicationController  
  def add_game
    @samplegame = Samplegame.new(params[:samplegame])
    
    if request.post? and @samplegame.save
      flash[:notice] = "Game added"
      @samplegame.update_attribute(:author_type, 1)
      redirect_to(:controller => "admin", :action => "add_game")
    end
  end
end
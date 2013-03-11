class Warp < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :samplegame
  
  def self.best_warps(n, game_id)
    Warp.find(:all, :limit => 5, 
      :conditions => 'samplegame_id = ' + game_id.to_s + ' AND score IS NOT NULL',
      :order => 'score DESC')
  end
end

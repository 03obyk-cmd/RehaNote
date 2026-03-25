class HomesController < ApplicationController
  allow_unauthenticated_access
  
  def top
    @communities = Community.all
  end

  def about
  end
end

Quaker::Application.routes.draw do
  get '/quakes', to: 'quakes#regions', constraints: RegionConstraint
  get '/quakes', to: 'quakes#quakes'
  get '/quakes/vis', to: 'quakes#vis'

  root to: redirect('/quakes')

  class RegionConstraint
    def self.matches?(request)
      request.params[:region] == 'true'
    end
  end
end



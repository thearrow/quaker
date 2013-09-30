Quaker::Application.routes.draw do

  get '/quakes', to: 'quakes#index'

  get '/quakes/vis', to: 'quakes#vis'

  root to: redirect('/quakes')

end

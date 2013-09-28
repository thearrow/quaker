Quaker::Application.routes.draw do

  get '/quakes', to: 'quakes#index'

  get '/vis', to: 'vis#index'

  root to: redirect('/quakes')

end

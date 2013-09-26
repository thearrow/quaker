Quaker::Application.routes.draw do

  get '/quakes', to: 'quakes#index'

  root to: redirect('/quakes')

end

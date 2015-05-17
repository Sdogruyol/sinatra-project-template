require './cheetah'

map Cheetah.assets_prefix do
  run Cheetah.assets
end

map '/' do
  run Cheetah
end

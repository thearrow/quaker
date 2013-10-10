json.array! [['Lat', 'Long', 'Avg. Magnitude', '# Quakes']] + @regions.collect {|r| r.vis_output(@days)}

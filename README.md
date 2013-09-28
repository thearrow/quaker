QuakerJake
=====

[quakerjake.herokuapp.com](http://quakerjake.herokuapp.com)

An Earthquake Information application that provides a public HTTP interface.


Setup
-----
```
git clone git@github.com:thearrow/quaker.git
cd quaker
bundle install
bundle exec rake reload_data
rails s
```


Usage
-----
####`GET /quakes<.json>?<params>`
Displays an html list or json output of the highest-magnitude quakes or most-dangerous regions.
```
params:
count     -> Integer; Maximum number of quakes/regions to return. Defaults to 10.
days      -> Integer; (1 <= days <= 30). Number of days from today to look back. Defaults to 10.
region    -> Boolean; If true, return regions. If false or not present, returns quakes
```
Examples:
- `/quakes?days=2` Display a list of the (10) highest-magnitude quakes from the past 2 days
- `/quakes.json?count=5` Return the 5 highest-magnitude quakes (from past 10 days) in original JSON
- `/quakes?region=true&days=5` Return the (10) most-dangerous 'regions' from the past 5 days
- `/quakes.json?region=true` Return the (10) most-dangerous 'regions' (from past 10 days) in JSON
  - (A 'region' is defined as the 25-mile radius surrounding an individual quake.)

####`GET /vis`
Displays a Google Geochart visualization of the 100 most-dangerous regions from the past 30 days.


Info
-----
- Ruby on Rails
  - Environment Variables:
    - `USGS_API_URL=http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_month.geojson`

- MongoDB
  - [Mongoid ODM](http://mongoid.org)
  - [2dsphere Geospatial Indexing](http://docs.mongodb.org/manual/applications/geospatial-indexes)

- [USGS Earthquake API](http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php)
  - Currently updated daily at 1:00 via rake task `reload_data` (heroku scheduler)
  - Can be updated manually by running `heroku run rake reload_data`

- [Google Geochart Visualization](https://developers.google.com/chart/interactive/docs/gallery/geochart)
  - Marker size represents number of quakes in the region, color represents average magnitude.


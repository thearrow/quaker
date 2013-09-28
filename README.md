QuakerJake
=====

[quakerjake.herokuapp.com](http://quakerjake.herokuapp.com)

An Earthquake Information application that provides a public HTTP interface.


Usage
-----
```
GET /quakes<.json>?<params>

params:
count     -> Integer; Maximum number of quakes/regions to return. Defaults to 10.
days      -> Integer; (1 <= days <= 30). Number of days from today to look back. Defaults to 10.
region    -> Boolean; If true, return regions. If false or not present, returns quakes
```
Examples:
- `/quakes?days=2` Display a list of the (10) highest-magnitude quakes from the past 2 days
- `/quakes.json?count=5` Return the 5 highest-magnitude quakes (from past 10 days) in original JSON
- `/quakes?region=true&days=5` Return the (10) most dangerous 'regions' from the past 5 days
- `/quakes.json?region=true` Return the (10) most dangerous 'regions' (from past 10 days) in JSON
  - (A 'region' is defined as the 25-mile radius surrounding an individual quake.)


Behind-the-Scenes
-----
- Ruby on Rails
- MongoDB
  - [Mongoid ODM](http://mongoid.org)
  - [2dsphere Geospatial Indexing](http://docs.mongodb.org/manual/applications/geospatial-indexes)
- [USGS Earthquake API](http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php)
  - Currently updated daily at 1:00 via rake task `reload_data` (heroku scheduler)
  - Can be updated manually by running `heroku run bundle exec rake reload_data`

- Environment Variables:
  - `USGS_API_URL=http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/2.5_month.geojson`
  - `REGION_RADIUS=40233.6` Default radius in meters for region creation (40233.6m = 25miles)
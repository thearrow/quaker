QuakerJake
=====

[quakerjake.herokuapp.com](http://quakerjake.herokuapp.com)

An Earthquake Information application that provides a public HTTP interface.


Usage
-----
```
GET /quakes?<params>

count     -> Integer; Number of quakes to return. Defaults to 10
days      -> Integer; Number of days from today to look back. Defaults to 10
region    -> Boolean; If true, return regions. If false or not present, stick with "places"
json      -> Boolean; If true, return results in original, pretty-printed JSON from USGS API. If false, display HTML list.
```
Examples:
- `/quakes?count=5&json=true` Return the 5 highest-magnitude quakes (from past 10 days) in original JSON
- `/quakes?days=2` Display a list of the (10) highest-magnitude quakes from the past 2 days


Behind-the-Scenes
-----
- Ruby on Rails
- MongoDB
  - [Mongoid ODM](http://mongoid.org)
  - Native 2dsphere [Geospatial Indexing](http://docs.mongodb.org/manual/applications/geospatial-indexes)
- [USGS Earthquake API](http://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php)
  - Currently updated daily at 1:00 via rake task `reload_data` (heroku scheduler)
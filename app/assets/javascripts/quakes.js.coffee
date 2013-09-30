drawMarkersMap = ->
  quakes = []
  $.get('/quakes.json?days=30&count=100&region=true&vis=true').done (q) ->
    quakes = q
    data = google.visualization.arrayToDataTable(quakes)
    options =
      displayMode: "markers"
      colorAxis:
        colors: ["yellow", "red"]
    chart = new google.visualization.GeoChart(document.getElementById("chart_div"))
    chart.draw data, options

if google?
  google.load "visualization", "1", packages: ["geochart"]
  google.setOnLoadCallback drawMarkersMap
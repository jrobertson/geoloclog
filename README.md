# Introducing the geoloclog gem

    require 'geoloclog'
    require 'chronic_duration'


    # logging is started
    gll = GeoLocLog.new labels: 'labels.yaml'
    gll.add 55.9432475, -3.1420572

    # logging ends

    # minutes later logging starts again
    gll = GeoLocLog.new 'geoloclog.xml', labels: 'labels.yaml'
    gll.add 55.9592332, -3.1375362

    # logging ends

    # a few minutes later, logging starts once more
    gll = GeoLocLog.new labels: 'labels.yaml'
    gll.add 55.9432475, -3.1420572


    loc = gll.last_location
    last_seen = ChronicDuration.output((Time.now - Time.parse(loc.lastseen)).round)  
    puts "%s was last seen at %s %s ago" % ['James', 
                                              loc.label || loc.place, last_seen]

    #=> "James was last seen at home 1 min 24 secs ago"

# file: labels.yaml

<pre>
---
Duddingston Road West: home
Highriggs Way: Building 1
</pre>

The geoloclog gem is intended to locate me relative to a place name which can either be a street name or a user-defined name whichs maps to a place name for the sake of privacy.

Notes: 

1. I have used a fake home address in the above example
2. The coordinates are automatically converted to place names
3. This gem relies upon the geocoder gem which relies upon the Google API which sometimes may return an error if the service is too busy.


## Resources

* geoloclog https://rubygems.org/gems/geoloclog

geoloclog gps location tracking logging


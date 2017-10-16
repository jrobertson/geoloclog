#!/usr/bin/env ruby

# file: geoloclog.rb


require 'glw'
require 'dynarex-daily'


# options:
# 
#  file: used to store the place names and the coordinates
#  wait: records can only be added after the given wait time in seconds
#  labels: Maps the returned place name with a user-defined label (optional)
#  dbfile: sqlite database file used to store an addresses with a position
#  timeout: number of seconds to wait before the Geocoder gem 
#           timesout when accessing the Google API

class GeoLocLog

  def initialize(file='geoloclog.xml', wait: 60, labels: nil, dbfile: 'glw.db', 
                timeout: 10)

    @filename, @wait = file, wait
   
    @labels = labels ? YAML.load(RXFHelper.read(labels).first) : {}

    @dx = if File.exists? file then
      DynarexDaily.new file
    else
      dx = DynarexDaily.new 'geoloc[title, date]/location(place, label, ' + 
               'entered, lastseen, address, coords)', filename: @filename
      dx.default_key = 'uid'
      dx
    end

    @glw = Glw.new dbfile, timeout: timeout

  end

  def add(lat, lon)

    return if location and  (Time.now - Time.parse(location.created) < @wait)

    begin
      h = @glw.locate lat, lon
    rescue
      puts 'geoloclog::add warning: ' + ($!).inspect
      return
    end

    record = {
      place: h[:route],
      label: @labels[h[:route]].to_s,
      entered: Time.now,
      lastseen: Time.now,
      address: h[:address],
      coords: [lat, lon].join(', ')
    }

    @dx.create record
    @dx.save @filename

  end

  def last_location()
    @dx.all.any? ? @dx.all.first : nil
  end

  alias location last_location

end

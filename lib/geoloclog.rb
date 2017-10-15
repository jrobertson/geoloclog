#!/usr/bin/env ruby

# file: geoloclog.rb


require 'glw'
require 'dynarex-daily'


class GeoLocLog

  def initialize(file='geoloclog.xml', wait: 60, labels: nil, dbfile: 'glw.db', 
                timeout: 10)

    @filename = file
   
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

    h = @glw.locate lat, lon

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

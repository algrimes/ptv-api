A higher-level API on top of the PTV timetable API. Aims:

* Improve API navigation so that no arcane knowledge is required
* Extend and re-structure API to be more based around resources

###Getting Started

Add it to your gemfile:

	gem "ptv_api"

Require it:

	require 'ptv_api'

Create the api by passing in your key and dev id:

    api = PTVApi.new(12345, "2234rsd-wewr33-qwefwd")

###Usage

Entry points are still in a bit of flux. For now:

	results = api.search("North Melbourne")

This gives you a search result object from which you can get stops and lines, optionally filtering by transport type:

	results.stops
	results.stops(TransportType::TRAIN)
	results.lines
	results.lines(TransportType::BUS)

You can query which lines a stop serves:

	results.stops(TransportType::TRAIN)[0].lines

which stops are on a line:

	results.lines(TransportType::BUS)[0].stops

which platforms (line + direction combination) the stop has available:

	results.stops(TransportType::TRAIN)[0].platforms

and from there query departures:

	results.stops(TransportType::TRAIN)[0].platforms[0].departures

You can also start with a location, calling stops near me, and going from there:

	Location.new(api, "-23.34234", "44.23123").stops_near_me



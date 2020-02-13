# Haxe Summit Website Generator

![Deploy](https://github.com/ibilon/summit.haxe.org/workflows/Deploy/badge.svg)

## Building

* You need Haxe and Haxelib.
* Install the dependencies with `haxelib install generate.hxml`.
* Generate the website using `haxe generate.hxml`.

The website is now available in the `out/` folder, you can launch it with `nekotools server -d out` and access it at <http://localhost:2000/>.

## Adding a new event

* Create a folder `eventId/` in `data/`.
* Add the header's background image in `data/eventId/images/background.jpg`.
* Edit `data/current.txt` to `eventId` if you wish to make the event the default one when accessing the root url.

### Configuration

Create the file `data/eventId/config.json` with the following content:

* `address`: The event's venue's address.
* `earlyBirdEndDate`: The end date for the early bird tickets.
* `eventBriteId`: The eventbrite event id.
* `dates`: The event dates, `month start-end`.
* `length`: The number of days for the event, in english.
* `mapUrl`: Iframe url for the venu map.
* `price`: Full ticket price, including the money symbol.
* `speakingLink`: Link where to apply for a talk.
* `speakingOpen`: Can people still apply for a talk.
* `stage`: The current stage: "EarlyPlanning", "TicketsOpen", "TicketsClosed", "EventOngoing" or "EventConcluded".
* `town`: The venue's town name.
* `year`: The event year.
* `zone`: The event zone, eg `US`, `EU`...

### Adding a speaker

Edit `data/eventId/speakers.json` and add an entry:
```json
{
	"id": "The speaker's id used as url and when linking the talks",
	"image": "The speaker's photo filename",
	"name": "The speaker's name",
	"title": "The speaker's title",
	"bio": "Short description about the speaker"
}
```

If the file doesn't exist the starting content should be `[]`.

Add the speaker's photo in `data/eventId/images/speakers/$image`.

### Adding a talk

Add a file named `id.md` in `data/eventId/talks`.

The first part of the file contains the talk metadata:
```yml
speaker: The speaker's id
title: The talk's title
description: Short description about the talk
---
```

The rest of the file contains the full length description of the talk, in markdown format.

# Haxe Summit Website Generator

## Building

* You need Haxe and Haxelib.
* Install the dependencies with `haxelib install generate.hxml`.
* Generate the website using `haxe generate.hxml`.

The website is now available in the `out/` folder, you can launch it with `nekotools server -d out` and access it at <http://localhost:2000/>.

## Configuration

* `address`: The summit venue address.
* `earlyBirdEndDate`: The end date for the early bird tickets.
* `eventBriteId`: The eventbrite event id.
* `dates`: The event dates, `month start-end`.
* `length`: The number of days for the event, in english.
* `mapUrl`: Iframe url for the venu map.
* `outputFolder`: `out` is recommended.
* `price`: Full ticket price, including the money symbol.
* `speakingLink`: Link where to apply for a talk.
* `speakingOpen`: Can people still apply for a talk.
* `ticketOpen`: Can people buy the tickets.
* `town`: The venue's town name.
* `year`: The event year.
* `zone`: The event zone, eg `US`, `EU`...

## Adding a speaker

Edit `data/speakers.json` and add an entry:
```json
{
	"id": "speaker id used as url and to link with talks",
	"name": "The speaker's name",
	"title": "The speaker's title",
	"bio": "Short description about the speaker"
}
```

Add the speaker photo in `data/images/speakers/$image`.

## Adding a talk

Add a file named `id.md` in `data/talks`.

The first part of the file contains the talk metadata:
```yml
speaker: The speaker id
title: The talk's title
description: Short description about the talk
---
```

The rest of the file contains the full length description of the talk, in markdown format.

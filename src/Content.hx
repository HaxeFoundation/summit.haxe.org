import haxe.io.Path;
import json2object.ErrorUtils;
import json2object.JsonParser;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Speaker {
	public var id:String;
	public var image:String;
	public var name:String;
	public var title:String;
	public var bio:String;
	@:jignored public var talks:Array<Talk>;
}

class Talk {
	public var id:String;
	public var title:String = "";
	public var description:String = "";
	public var content:String = "";
	public var speaker:String = "";
	public var time:String = "";

	public function new() {}
}

class Content {
	public var speakers:Array<Speaker>;
	public var talks:Array<Talk>;
	public var id2speaker:Map<String, Speaker>;

	function new(config:Config) {
		// Speakers
		var parser = new JsonParser<Array<Speaker>>();
		var fpath = Path.join([config.path, "speakers.json"]);
		parser.fromJson(File.getContent(fpath), fpath);

		if (parser.errors.length != 0) {
			throw ErrorUtils.convertErrorArray(parser.errors);
		}

		speakers = parser.value;
		for (speaker in speakers) {
			speaker.talks = [];
		}

		id2speaker = [for (speaker in speakers) speaker.id => speaker];

		// Talks
		talks = [];
		var path = Path.join([config.path, "talks"]);
		var delimiter = "\n---";

		for (talk in FileSystem.readDirectory(path)) {
			var content = File.getContent(Path.join([path, talk]));
			var splitted = content.split(delimiter);
			var header = splitted.shift();
			var content = splitted.join(delimiter);
			var id = Path.withoutExtension(talk);

			var talk = new Talk();
			talk.id = id;
			talk.content = Markdown.markdownToHtml(content);
			talks.push(talk);

			for (line in header.split("\n")) {
				var tmp = line.split(":");
				var key = tmp.shift().trim();
				var value = tmp.join(":").trim();

				switch (key) {
					case "speaker":
						if (!id2speaker.exists(value)) {
							throw 'Unknown speaker id "$value"';
						}

						talk.speaker = value;
						id2speaker[value].talks.push(talk);

					case "title":
						talk.title = value;

					case "description":
						talk.description = value;

					case other:
						throw 'Unknown talk header key "$other"';
				}
			}
		}
	}

	public static function generate(config:Config) {
		var content = new Content(config);

		// Index
		Sys.println("Generating index page ...");
		Utils.save(config, "", "index.html", Views.index(content, config), ["index"]);

		// Speakers page
		for (speaker in content.speakers) {
			var warning = speaker.talks.length == 0 ? " WARNING no talk for the speaker" : "";
			Sys.println('Generating speaker page for ${speaker.name} ...$warning');
			Utils.save(config, "../../", Path.join(["speakers", speaker.id, "index.html"]), Views.speaker(speaker), speaker.name);
		}

		// Talks
		for (talk in content.talks) {
			Sys.println('Generating talk page for ${talk.title} ...');
			var speaker = content.id2speaker[talk.speaker];
			Utils.save(config, "../../", Path.join(["talks", talk.id, "index.html"]), Views.talk(talk, speaker), '${talk.title} by ${speaker.name}');
		}
	}
}

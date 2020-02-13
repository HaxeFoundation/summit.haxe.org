import haxe.io.Path;
import json2object.ErrorUtils;
import json2object.JsonParser;
import sys.io.File;

enum abstract EventStage(String) from String {
	var EarlyPlanning;
	var TicketsOpen;
	var TicketsClosed;
	var EventOngoing;
	var EventConcluded;
}

class Config {
	public var address:String;
	public var earlyBirdEndDate:String;
	public var eventBriteId:String;
	public var dates:String;
	public var length:String;
	public var mapUrl:String;
	public var price:String;
	public var speakingLink:String;
	public var speakingOpen:Bool;
	public var stage:EventStage;
	public var town:String;
	public var year:Int;
	public var zone:String;
	@:jignored public var outputFolder:String;
	@:jignored public var path:String;

	public static function get(path:String):Config {
		var parser = new JsonParser<Config>();
		var fpath = Path.join([path, "config.json"]);
		parser.fromJson(File.getContent(fpath), fpath);

		if (parser.errors.length != 0) {
			throw ErrorUtils.convertErrorArray(parser.errors);
		}

		var config = parser.value;
		config.zone = config.zone.toLowerCase();
		config.outputFolder = Path.join(["out", config.zone, '${config.year}']);
		config.path = path;

		return config;
	}
}

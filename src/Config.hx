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
	public var outputFolder:String;
	public var price:String;
	public var speakingLink:String;
	public var speakingOpen:Bool;
	public var stage:EventStage;
	public var town:String;
	public var year:Int;
	public var zone:String;

	static var _config:Config;

	public static function get():Config {
		if (_config == null) {
			var parser = new JsonParser<Config>();
			var path = "data/config.json";
			parser.fromJson(File.getContent(path), path);

			if (parser.errors.length != 0) {
				throw ErrorUtils.convertErrorArray(parser.errors);
			}

			_config = parser.value;
		}

		return _config;
	}
}

import tink.template.Html;

class Views {
	@:template public static function index(content:Content, config:Config):Html;

	@:template public static function main(content:Html, config:Config, extraStyles:Array<String>):Html;

	@:template public static function speaker(speaker:Content.Speaker):Html;

	@:template public static function talk(talk:Content.Talk, speaker:Content.Speaker):Html;
}

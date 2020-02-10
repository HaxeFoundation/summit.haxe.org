import sys.FileSystem;

class Main {
	static function main() {
		var config = Config.get();

		Sys.println("== summit.haxe.org generation ==");
		Sys.println('Output folder: "${config.outputFolder}"');
		var start = Date.now().getTime();

		// Make sure the output folder exists
		if (!FileSystem.exists(config.outputFolder)) {
			FileSystem.createDirectory(config.outputFolder);
		}

		// Generating the content
		Assets.generate();
		Content.generate();

		var end = Date.now().getTime();
		Sys.println('Generation complete, time ${(end - start) / 1000}s');
	}
}

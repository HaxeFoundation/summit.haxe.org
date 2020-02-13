import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

using StringTools;

class Main {
	static function main() {
		Sys.println("== summit.haxe.org generation ==");
		var start = Date.now().getTime();

		// Redirect root url to current event
		Sys.println('++ root ++\nGenerating index page ...');
		var current = Config.get(Path.join(["data", File.getContent("data/current.txt").trim()]));
		Utils.save(current, "", "../../index.html", Views.redirection('${current.zone}/${current.year}/')); // TODO rootPath

		// Make sure the output folder exists
		FileSystem.createDirectory("out");

		for (event in Utils.listDirectories("data")) {
			Sys.println('++ $event ++');

			var path = Path.join(["data", event]);
			var config = Config.get(path);

			FileSystem.createDirectory(config.outputFolder);

			// Generating the content
			Assets.generate(config);
			Content.generate(config);
		}

		var end = Date.now().getTime();
		Sys.println('Generation complete, time ${(end - start) / 1000}s');
	}
}

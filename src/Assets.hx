import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;

class Assets {
	public static function generate(config:Config) {
		// Copy common assets
		Sys.println('Copying assets from "www" to "${config.outputFolder}" ...');
		recursiveCopy("www", config.outputFolder);

		// Copy event specific assets
		Sys.println('Copying assets from "${config.path}/images" to "${config.outputFolder}/images" ...');
		recursiveCopy(Path.join([config.path, "images"]), Path.join([config.outputFolder, "images"]));
	}

	static function recursiveCopy(inPath:String, outPath:String) {
		for (entry in FileSystem.readDirectory(inPath)) {
			copyFromDataFolder(entry, inPath, outPath);
		}
	}

	static function copyFromDataFolder(entry:String, inPath:String, outPath:String) {
		var inPath = Path.join([inPath, entry]);
		var outPath = Path.join([outPath, entry]);

		if (FileSystem.isDirectory(inPath)) {
			FileSystem.createDirectory(outPath);

			for (entry in FileSystem.readDirectory(inPath)) {
				copyFromDataFolder(entry, inPath, outPath);
			}
		} else {
			File.copy(inPath, outPath);

			if (Path.extension(outPath) == "css") {
				File.saveContent(outPath, Utils.minifyCss(File.getContent(outPath)));
			}
		}
	}
}

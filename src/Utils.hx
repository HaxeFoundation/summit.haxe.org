import haxe.io.Path;
import sys.FileSystem;
import sys.io.File;
import tink.template.Html;

class Utils {
	public static function listDirectories(path:String):Array<String> {
		return FileSystem.readDirectory(path).filter(e -> FileSystem.isDirectory(Path.join([path, e])));
	}

	public static function minifyCss(content:String):String {
		content = ~/(\/\*\*?(.|\n)+?\*?\*\/)/g.replace(content, "");
		// adapted from https://gist.github.com/clipperhouse/1201239/cad48570925a4f5ff0579b654e865db97d73bcc4
		content = ~/\s*([,>+;:}{]{1})\s*/ig.replace(content, "$1");
		content = content.split(";}").join("}");
		return content;
	}

	public static inline function minifyHtml(content:String):String {
		// adapted from http://stackoverflow.com/questions/16134469/minify-html-with-boost-regex-in-c
		return new EReg("(?ix)(?>[^\\S]\\s*|\\s{2,})(?=[^<]*+(?:<(?!/?(?:textarea|pre|script|code)\\b)[^<]*+)*+(?:<(?>textarea|pre|script|code)\\b|\\z))",
			"ig").replace(content, " ");
	}

	/* Wrap the page into the main layout and output it. */
	public static function save(config:Config, rootPath:String, outPath:String, content:Html, ?title:String, ?extraStyles:Array<String>) {
		var outPath = Path.join([config.outputFolder, outPath]);
		var dir = Path.directory(outPath);
		FileSystem.createDirectory(dir);

		if (title == null) {
			title = "";
		}

		if (extraStyles == null) {
			extraStyles = [];
		}

		File.saveContent(outPath, minifyHtml(Views.main(rootPath, title, content, config, extraStyles)));
	}
}

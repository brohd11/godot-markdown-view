extends SceneTree
## Clean-compile headless entry for the markdown_view suites, exiting with a CI code.
##     godot --headless --path . --script res://addons/_lib/markdown_view/_export_ignore/test/run_headless.gd

const SUITES:PackedStringArray = [
	"res://addons/_lib/markdown_view/_export_ignore/test/markdown_parser_test.gd",
]


func _initialize() -> void:
	var success = true
	var output:Array[String] = []
	for path in SUITES:
		var script = load(path)
		if script == null: # a missing suite fails the run instead of halting it
			success = false
			output.append("FAIL  could not load " + path)
			continue
		var res:Dictionary = script.run_tests()
		success = success and res.result == 0
		output.append_array(res.output)

	print("\n".join(output))
	quit(0 if success else 1)

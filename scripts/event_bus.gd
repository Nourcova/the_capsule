extends Node

signal damage_signal
signal nextLevel

var level = ["res://scenes/Level1.tscn","res://scenes/Level2.tscn"]
var currentLevel = 0
func _ready():
	EventBus.nextLevel.connect(levelFinished)
	
func levelFinished():
	if currentLevel !=1:
		currentLevel += 1
		get_tree().change_scene_to_file.bind(level[currentLevel]).call_deferred()
	else:
		get_tree().change_scene_to_file.bind("res://scenes/startScene.tscn").call_deferred()
		currentLevel = 0
	

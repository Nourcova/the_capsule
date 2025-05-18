extends Button


func _on_pressed():
	get_tree().change_scene_to_file.bind("res://scenes/Level1.tscn").call_deferred()

extends Area3D

func _on_body_entered(body):
	if body is CharacterBody3D:
		EventBus.damage_signal.emit()

extends CharacterBody3D

var myName = "Nour"
var age = 20
var max_health = 100
var health = max_health
var isAlive = true
var lives = 3
var startingPosition
var invincible = false
var original_color = Color(1,1,1)
var invincibal_color = Color(1,0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	print ("My name is: " + myName + " and my age is: " + str(age) )
	update_ui()
	startingPosition = position
	EventBus.damage_signal.connect(take_damage)
	original_color = $MeshInstance3D.mesh.surface_get_material(0).albedo_color
	

func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		position.z-= 10 * delta
	if(Input.is_action_pressed("ui_down")):
		position.z+= 10 * delta
	if(Input.is_action_pressed("ui_right")):
		position.x+= 10*delta
	if(Input.is_action_pressed("ui_left")):
		position.x-= 10*delta
	if not is_on_floor():
		velocity+= get_gravity()*delta
	move_and_slide()
	update_ui()
	
	if(health<=0 or position.y<=-1):
		if(isAlive):
			die()
	
func take_damage():
	if !invincible:
		if isAlive:
			health -= 25
			print(health)
			update_ui()
			invincible = true
			set_player_color(invincibal_color)
			$InvincibilityTimer.start()
			$Ouch.play()
		
func update_ui():
	$CanvasLayer/Control/Health.value = health
	$CanvasLayer/Control/Label.text = "Lives: " + str(lives)
	
func die():
	health = 0 #double check
	isAlive = false
	lives -= 1
	print('you died, lives left : ' + str(lives))
	respawn()

func respawn():
	if(lives>0):
		health = max_health
		isAlive = true
		position = startingPosition
		update_ui()
		set_player_color(original_color)
		invincible = false
	else:
		get_tree().change_scene_to_file.bind("res://scenes/GameOverScene.tscn").call_deferred()

func set_player_color(color):
	var material = $MeshInstance3D.mesh.surface_get_material(0)
	material.albedo_color = color
	$MeshInstance3D.mesh.surface_set_material(0, material)
	
func _on_invincibility_timer_timeout():
	set_player_color(original_color)
	invincible = false

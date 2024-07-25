extends Node2D


var player = preload("res://Scripts/Player.gd").new()
var fireball_scene = preload("res://Scenes/fireball.tscn")
func cast_spell():
	if player.keystrokes.size() > 0:
		print("Casting spell with keystrokes: ", player.keystrokes)
		player.keystrokes.clear()
	if player.keystrokes[0] == "Up" and player.keystrokes[1] == "Up":
		print("Casting Fireball!")
		shoot_fireball()
		print("No keystrokes to cast a spell.")
	else:
		print("No keystrokes to cast a spell.")


func shoot_fireball():
		var fireball = fireball_scene.instantiate()
		fireball.position = position
		fireball.direction = $Sprite2D.scale.x * Vector2.RIGHT # Assuming the player faces right with positive scale
		get_parent().add_child(fireball)
		print("Fireball shot!")

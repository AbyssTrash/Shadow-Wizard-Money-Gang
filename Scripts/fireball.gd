extends Area2D

var velocity = Vector2()
var lifetime = 2.0 # Lifetime in seconds

func _ready():
	set_process(true)
	get_tree().create_timer(lifetime)

func _process(delta):
	position += velocity * delta

func _on_Fireball_body_entered(body):
	# Handle collision (e.g., deal damage)
	queue_free()

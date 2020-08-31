extends KinematicBody2D
class_name Actor

var speed: int = 200
var jumpForce: int = 500
var gravity: int = 800

var velocity: Vector2 = Vector2.ZERO

func _ready():
	pass # Replace with function body

func _physics_process(delta):
	velocity.y += gravity * delta
#func _process(delta):
#	pass

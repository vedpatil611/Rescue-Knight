extends KinematicBody2D

func _ready():
	sprite = get_node("Sprite")
	
var speed: int = 200
var jumpForce: int = 600
var gravity: int = 800

var velocity: Vector2 = Vector2.ZERO

var sprite: AnimatedSprite = null

func _physics_process(delta):
	# Movement input
	if(Input.is_action_pressed("move_left")):
		velocity.x = -speed
		sprite.flip_h = true
		if(is_on_floor()):
			sprite.play("run")
		else:
			sprite.play("fall")
	elif (Input.is_action_pressed("move_right")):
		velocity.x = +speed
		sprite.flip_h = false
		if(is_on_floor()):
			sprite.play("run")
		else:
			sprite.play("fall")
	else:
		velocity.x = 0
		if(is_on_floor()):
			sprite.play("idle")
		else:
			sprite.play("fall")
		
	# gravity action
	velocity.y += gravity * delta
	
	#jump
	if(Input.is_action_just_pressed("jump") && is_on_floor()):
		velocity.y = -jumpForce
		sprite.play("jump")
		
	# movemnet with velocity
	move_and_slide(velocity, Vector2.UP)

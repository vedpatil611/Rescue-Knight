extends KinematicBody2D

func _ready():
	sprite = get_node("Sprite")
	
var speed: int = 200
var jumpForce: int = 600
var gravity: int = 800
var swordDamageCollion: int = 24

var isAttacking: bool = false

var velocity: Vector2 = Vector2.ZERO

var sprite: AnimatedSprite = null

func _physics_process(delta):
	# Movement input
	if(!isAttacking):
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
		
		#jump
		if(Input.is_action_just_pressed("jump") && is_on_floor()):
			velocity.y = -jumpForce
			sprite.play("jump")
		
	# gravity action
	velocity.y += gravity * delta
	
	# attack
	if(Input.is_action_just_pressed("attack")):
		sprite.play("attack1")
		velocity.x = 0
		isAttacking = true
		get_tree().get_root().set_disable_input(true)
	# movemnet with velocity
	move_and_slide(velocity, Vector2.UP)


func _on_Sprite_animation_finished():
	if(sprite.animation == "attack1"):
		isAttacking = false
		get_tree().get_root().set_disable_input(false)

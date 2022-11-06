extends KinematicBody2D

var velocity = Vector2(0,0)
var SPEED = 300
const JUMPFORCE = -1000
var dash_speed = 0
var active_dash = 500
var GRAVITY = 70
var dash_speed_changer = 20
var normal_gravity =70
var extreme_gravity = 100
var crouch_speed = 50

var high_score = 123





# warning-ignore:unused_argument
func _physics_process(delta):	
	 
	if Input.is_action_pressed("right"):
		$Sprite.flip_h = false
		$Sprite.play("Walking")
		velocity.x = SPEED + dash_speed
		if dash_speed != 0:
			$Sprite.play("Dash")
			dash_speed -=dash_speed_changer
	
	elif Input.is_action_pressed("left"):
		$Sprite.flip_h = true
		$Sprite.play("Walking")
		velocity.x = -SPEED -dash_speed
		if dash_speed != 0:
			$Sprite.play("Dash")
			dash_speed -=dash_speed_changer
	elif !(Input.is_action_pressed("left")) and !(Input.is_action_pressed("right")):
		$Sprite.play("Idle")
	
	velocity.y += GRAVITY
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$Sprite.play("jump")
		velocity.y = JUMPFORCE
		
	if (Input.is_action_just_pressed("dash") and Input.is_action_pressed("left")) or (Input.is_action_just_pressed("dash") and Input.is_action_pressed("right")): 
		dash_speed = active_dash
		high_score += 1
		yield(get_tree().create_timer(3.0), "timeout")
		
	if Input.is_action_pressed("crouch")and Input.is_action_just_pressed("jump") and !(Input.is_action_pressed("left")) and !(Input.is_action_pressed("right")) and is_on_floor():
		$Sprite.play("jump")
		GRAVITY = normal_gravity
		velocity.y = JUMPFORCE - 350

	if Input.is_action_pressed("crouch"):
		GRAVITY = extreme_gravity
		scale = Vector2(1.5, .5)
		if Input.is_action_pressed("right"):
			velocity.x = crouch_speed + dash_speed
			if dash_speed != 0:
				dash_speed -=dash_speed_changer
		if Input.is_action_pressed("left"):
			velocity.x = -crouch_speed -dash_speed
			if dash_speed != 0:
				dash_speed -=dash_speed_changer
	else:
		scale = Vector2(1, 1)
		GRAVITY = normal_gravity
	
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.3)
	

func _on_exit1_body_entered(body):
	print("bruh")
	get_tree().change_scene("res://Level2.gd")
	$SecondCam.make_current()
	$SecondCam.current = false
	
	
	
	
func _on_exit2_body_entered(body):
	print("bruh2")
	get_tree().change_scene("Level3")
	$ThirdCam.make_current()
	$ThirdCam.current = false


func _on_startButton_pressed():
	get_tree().change_scene("res://Level1.tscn")
#	get_tre/e().get("res://Level1/

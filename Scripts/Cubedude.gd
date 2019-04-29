extends KinematicBody

var motion = Vector3()

export var speed = 10

const UP = Vector3(0, 1, 0)
const GRAVITY = -5
const EPSILON = 0.000001

func _physics_process(delta):
	move()
	fall()
	
func _process(delta):
	animate()
	
func animate():
	if motion.length() > EPSILON:
		if !$AnimationPlayer.is_playing():
			$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop();
	
func move():
	if Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		motion.z = -speed
	elif Input.is_action_pressed("ui_down") and not Input.is_action_pressed("ui_up"):
		motion.z = speed
	else:
		motion.z = 0
	
	if Input.is_action_pressed("ui_left") and not Input.is_action_pressed("ui_right"):
		motion.x = -speed
	elif Input.is_action_pressed("ui_right") and not Input.is_action_pressed("ui_left"):
		motion.x = speed
	else:
		motion.x = 0
	
	move_and_slide(motion, UP)

func fall():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y = GRAVITY
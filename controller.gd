extends Node

var robot : KinematicBody2D
var camera : Camera2D
var MAX_SPEED = 2
var ACCELERATION = 100
var motion = Vector2.ZERO
var rotation_dir = 0

func _physics_process(delta):
	var axis = get_input_axis()
	if robot != null:
		robot.rotation += rotation_dir * 1.5 * delta
		if axis == Vector2.ZERO:
			apply_friction(ACCELERATION * delta)
		else:
			apply_movement(axis * ACCELERATION * delta)
		robot.move_and_collide(motion)
	
func get_input_axis():
	var axis = Vector2.ZERO
	rotation_dir = int(Input.is_action_pressed("robo_right")) - int(Input.is_action_pressed("robo_left"))
	axis.y = int(Input.is_action_pressed("robo_down")) - int(Input.is_action_pressed("robo_up"))
	return axis.normalized().rotated(robot.rotation)

func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO 

func apply_movement(amount):
	motion += amount
	motion = motion.clamped(MAX_SPEED)

# Called when the node enters the scene tree for the first time.
func _ready():
	robot = $"/root/sandbox/robot"
	camera = $"/root/sandbox/Camera2D"
	camera.get_parent().remove_child(camera)
	robot.add_child(camera)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("robo_action"):
		if robot.myname == "robot1":
			robot.remove_child(camera)
			robot = $"/root/sandbox/robot2"
			robot.add_child(camera)
		else:
			robot.remove_child(camera)
			robot = $"/root/sandbox/robot"
			robot.add_child(camera)

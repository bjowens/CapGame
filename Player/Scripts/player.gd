class_name Player extends CharacterBody2D


var cardinDirect : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var state_machine: PlayerStateMachine = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.Initialize(self)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	#direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	direction =  Vector2(
		Input.get_axis("left","right"),
		Input.get_axis("up","down")
	).normalized()
	
	
	
	
func _physics_process(delta: float) -> void:
	move_and_slide()



func setDirection()-> bool:
	var new_dir : Vector2 = cardinDirect
	if direction == Vector2.ZERO:
		return false
	if direction.y == 0:
		new_dir = Vector2.LEFT if direction.x < 0 else Vector2.RIGHT
	elif direction.x ==0:
		new_dir = Vector2.UP if direction.y < 0 else Vector2.DOWN
	
	
	if new_dir == cardinDirect:
		return false
	
	cardinDirect = new_dir
	sprite.scale.x = -1 if cardinDirect == Vector2.LEFT else 1
	return true
	
	

	
	
	
func updateAnimation(state: String)-> void:
	animation_player.play(state + "_" + animDirection())
	
	
func animDirection() -> String:
	if cardinDirect == Vector2.DOWN:
		return "down"
	elif cardinDirect == Vector2.UP:
		return "up"
	else:
		return"side"

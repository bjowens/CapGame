class_name State_Walk extends State

# Called when the node enters the scene tree for the first time.
@export var moveSpd : float = 100.0

@onready var idle: State = $"../Idle"
@onready var attack: State = $"../Attack"



#what happens when a player enters/exits this state
#what happens during the physics process/process and how it handles inputs
func Enter() -> void:
	player.updateAnimation("walk")
	pass
	
func Exit() -> void:
	pass
	
func Process(_delta:float) -> State:
	if player.direction == Vector2.ZERO:
		return idle
	
	player.velocity = player.direction*moveSpd
	
	if player.setDirection():
		player.updateAnimation("walk")
	return null
	
func Physics(_delta:float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attac"):
		return attack
	return null

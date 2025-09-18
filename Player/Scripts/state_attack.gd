class_name State_Attack extends State


@export var attack_sound : AudioStream
@export_range(1,20,0.5) var decelerate : float = 5.0
var attacking: bool = false
# Called when the node enters the scene tree for the first time.
@onready var walk: State = $"../Walk"
@onready var animation_player: AnimationPlayer = $"../../AnimationPlayer"
@onready var attack_animation_player: AnimationPlayer = $"../../Sprite2D/AttackFX/AttackAnimationPlayer"
@onready var idle: State = $"../Idle"
@onready var audio: AudioStreamPlayer2D = $"../../Audio/AudioStreamPlayer2D"

#what happens when a player enters/exits this state
#what happens during the physics process/process and how it handles inputs
func Enter() -> void:
	player.updateAnimation("attack")
	attack_animation_player.play("attack_" + player.animDirection())
	animation_player.animation_finished.connect(EndAttack)
	
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9,1.1)
	audio.play()
	
	attacking = true
	pass
	
func Exit() -> void:
	animation_player.animation_finished.disconnect(EndAttack)
	attacking = false
	pass
	
func Process(_delta:float) -> State:
	player.velocity -= player.velocity*decelerate*_delta
	
	if attacking == false:
		if player.direction == Vector2.ZERO:
			return idle
		else:
			return walk
	return null
	
func Physics(_delta:float) -> State:
	return null
	
func HandleInput(_event: InputEvent) -> State:
	return null
	
func EndAttack(_newAnimName: String)-> void:
	attacking = false

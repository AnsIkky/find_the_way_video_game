extends Node2D


@onready var play_button = $PlayButton
@onready var exit_button = $ExitButton
@onready var animation_player = $AnimationPlayer

var button_can_press : bool = false


func _ready():
	PauseHandler.can_pause = false
	Globals.player_live = Globals.max_lives
	
	animation_player.play("pop_up")
	await  animation_player.animation_finished
	
	button_can_press = true
	handle_connectiong_signal()


func on_play_button_pressed() -> void:
	if button_can_press == true:
		button_can_press = false
		animation_player.play_backwards("pop_up")
		TransitionLayer.change_scene("res://Scenes/Levels/transition_level/transition_level_01.tscn")

func on_exit_button_pressed() -> void:
	if button_can_press == true:
		button_can_press = false
		animation_player.play_backwards("pop_up")
		await animation_player.animation_finished
		get_tree().quit()


func handle_connectiong_signal() -> void:
	play_button.button_down.connect(on_play_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)

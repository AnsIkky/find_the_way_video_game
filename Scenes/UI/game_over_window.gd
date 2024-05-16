class_name GameOverWindow
extends CanvasLayer

@onready var animation_player = $AnimationPlayer as AnimationPlayer
@onready var window_status_label = $Control/WindowStatusLabel as Label
@onready var restart_button = $Control/RestartButton as Button
@onready var exit_button = $Control/ExitButton as Button

var button_status = ["Game Over", "Times Out"]


func _ready():
	not_active_button()
	handle_connecting_signal()


func _process(_delta):
	windows_status()


func window_active() -> void:
	if Globals.player_live <= 0:
		animation_process()


func restart_level() -> void:
	Globals.player_live = Globals.max_lives


func animation_process() -> void:
	animation_player.play("pop_up")
	await animation_player.animation_finished
	active_button()


func active_button() -> void:
	restart_button.disabled = false
	exit_button.disabled = false


func not_active_button() -> void:
	restart_button.disabled = true
	exit_button.disabled = true


func on_restart_button_pressed() -> void:
	not_active_button()
	animation_player.play_backwards("pop_up")
	await animation_player.animation_finished
	get_tree().reload_current_scene()
	restart_level()


func on_exit_button_pressed() -> void:
	print("exit button has been pressed")


func handle_connecting_signal() -> void:
	restart_button.button_down.connect(on_restart_button_pressed)
	exit_button.button_down.connect(on_exit_button_pressed)


func windows_status() -> void:
	if Globals.game_over == true:
		window_status_label.text = button_status[0]
	
	if Globals.times_out == true:
		window_status_label.text = button_status[1]

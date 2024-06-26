class_name LevelZero
extends Node2D

@onready var player = $EntityContainer/Player as CharacterBody2D
@onready var game_over_window = $UI/GameOverWindow as CanvasLayer
@onready var timer_label = $UI/Timer/Control/TimerLabel as Label

@export var level_timer_duration : float
var game_timer := Timer.new()


func _ready():
	PauseHandler.can_pause = true
	
	Globals.player_live = Globals.max_lives
	
	game_over_window_nonactive()
	create_game_timer()
	


func _process(_delta):
	update_timer()
	
	if PauseHandler.can_pause == false:
		game_timer.stop()


func _physics_process(_delta):
	# marking player position from the start of the game for respawn position if player die
	if Globals.player_live > 0:
		Globals.player_pos = player.global_position


func create_game_timer() -> void:
	add_child(game_timer)
	game_timer.one_shot = true
	game_timer.wait_time = level_timer_duration
	game_timer.timeout.connect(_on_timer_timeout)
	game_timer.start()


func _on_timer_timeout() -> void:
	when_level_timer_timeout()


# disabled game over windo while game still go on / player not die yet
func game_over_window_nonactive() -> void:
	if Globals.player_live > 0:
		set_physics_process(true)
		set_process(true)
		game_over_window.hide()
		game_over_window.set_process(false)


# enable when player lose all lives and end the game session
func game_over_window_active() -> void:
	PauseHandler.can_pause = false
	set_physics_process(false)
	set_process(false)
	game_over_window.show()
	game_over_window.set_process(true)
	game_over_window.window_active()


# apply timer to timer_label node
func update_timer() -> void:
	timer_label.text = "%d : %02d" % [floor(game_timer.time_left / 60), int(game_timer.time_left) % 60]


# give penalty to the player when game timer node reach 0 (same as game over)
func when_level_timer_timeout() -> void:
	Globals.game_over = false
	Globals.times_out = true
	
	if PauseHandler.can_pause == true:
		PauseHandler.can_pause = false
		game_over_window.show()
		game_over_window.animation_process()
		game_over_window.set_process(true)
		
		player.set_physics_process(false)
		player.player_status_when_timeout()
	else:
		return



#region function for animation zoomin when game start
func player_can_move() -> void:
	player.set_physics_process(true)


func player_cannot_move() -> void:
	player.set_physics_process(false)
#endregion


func _on_player_player_game_over():
	#Globals.game_over = true
	#Globals.times_out = false
	game_over_window_active()





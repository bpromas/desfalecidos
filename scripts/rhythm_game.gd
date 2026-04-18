extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var score_label: Label = $ScoreLabel
@onready var combo_label: Label = $ComboLabel

var combo := 0
var score := 0

var arrows_by_direction = {
	"up": [],
	"down": [],
	"left": [],
	"right": []
}

func get_song_time():
	return audio_stream_player.get_playback_position()

func handle_input(direction):
	var arrows = arrows_by_direction[direction]
	if arrows.is_empty():
		print("miss (no arrows)")
		return
#
	var current_time = get_song_time()
#
	var best_arrow = null
	var best_diff = INF
#
	for arrow in arrows:
		if arrow:
			var diff = abs(current_time - arrow.target_time)
			if diff < best_diff:
				best_diff = diff
				best_arrow = arrow
				
	judge(best_arrow, best_diff)
	
func judge(arrow, diff):
	var points := 0
	if diff < 0.05:
		print("Perfect")
		points += 100
		combo += 1
		arrow.hit()
	elif diff < 0.1:
		print("Great")
		points += 50
		combo += 1
		arrow.hit()
	elif diff < 0.25:
		print("Good")
		points += 25
		arrow.hit()
	else:
		combo = 0
		print("miss")
	
	score += points * combo
	combo_label.text = "x%s" % combo
	score_label.text = "%s" % score

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("ui_up"):
		handle_input("up")
	elif event.is_action_pressed("ui_down"):
		handle_input("down")
	elif event.is_action_pressed("ui_left"):
		handle_input("left")
	elif event.is_action_pressed("ui_right"):
		handle_input("right")

extends Node2D

@onready var audio_stream_player = $AudioStreamPlayer
@onready var score_label: RichTextLabel = $ScoreLabel
@onready var combo_label: RichTextLabel = $ComboLabel
@onready var accuracy_label: RichTextLabel = $AccuracyLabel
@onready var judgement_label: RichTextLabel = $JudgementLabel

var combo := 0
var best_combo := 0
var score := 0

var miss_count := 0
var good_count := 0
var great_count := 0
var perfect_count := 0
var total_count := 0
var accuracy := 100.0

signal broke_combo

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
		perfect_count+=1
		judgement_label.text = "[rainbow][shake][wave]PERFEITO"
		print("Perfect")
		points += 100
		combo += 1
		best_combo = max(combo, best_combo)
		arrow.hit()
	elif diff < 0.1:
		great_count+=1
		judgement_label.text = "[color=lightgreen][shake][wave]ÓTIMO"
		print("Great")
		points += 50
		combo += 1
		best_combo = max(combo, best_combo)
		arrow.hit()
	elif diff < 0.25:
		good_count+=1
		judgement_label.text = "[color=dodgerblue][shake]BOM"
		print("Good")
		points += 25
		arrow.hit()
	else:
		break_combo()
		print("miss")
	
	total_count += 1
	accuracy = ((perfect_count * 100.0) + (great_count * 85.0) + (good_count * 50)) / total_count
	print(accuracy)
	score += points * combo
	combo_label.text = "x%s" % combo
	accuracy_label.text = "%.2f%%" % accuracy
	if score >= 500000:
		score_label.text = "[rainbow]%s" % score
	else:
		score_label.text = "%s" % score
		
	
func break_combo():
	miss_count+=1
	combo = 0
	judgement_label.text = "[color=gray]errou..."
	combo_label.text = "x%s" % combo
	broke_combo.emit()

func _ready():
	combo_label.text = "x%s" % combo
	accuracy_label.text = "%.2f%%" % accuracy
	score_label.text = "%s" % score

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


func _on_audio_stream_player_finished() -> void:
	GlobalVariables.previous_score = score
	GlobalVariables.previous_best_combo = best_combo
	GlobalVariables.previous_miss_count = miss_count
	GlobalVariables.previous_good_count = good_count
	GlobalVariables.previous_great_count = great_count
	GlobalVariables.previous_perfect_count = perfect_count
	GlobalVariables.previous_accuracy = accuracy
	#get_tree().change_scene_to_file("res://scenes/cutscene_depois_do_teste.tscn")
	get_tree().change_scene_to_file("res://scenes/result_screen.tscn")


func _on_debug_finalizar_pressed() -> void:
	GlobalVariables.previous_score = score
	GlobalVariables.previous_best_combo = best_combo
	GlobalVariables.previous_miss_count = miss_count
	GlobalVariables.previous_good_count = good_count
	GlobalVariables.previous_great_count = great_count
	GlobalVariables.previous_perfect_count = perfect_count
	GlobalVariables.previous_accuracy = accuracy
	get_tree().change_scene_to_file("res://scenes/result_screen.tscn")

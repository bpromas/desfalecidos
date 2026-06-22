extends Control

@onready var perfect_count = $PerfectControl/PerfectCount
@onready var great_count = $GreatControl/GreatCount
@onready var good_count = $GoodControl/GoodCount
@onready var miss_count = $MissControl/MissCount
@onready var accuracy = $AccuracyControl/Accuracy
@onready var score = $Score
@onready var combo = $ComboControl/Combo


# Called when the node enters the scene tree for the first time.
func _ready():
	var global_score = GlobalVariables.previous_score
	var global_accuracy = GlobalVariables.previous_accuracy
	var shake_factor = clamp(remap(global_score, 0.0, 500000.0, 0.0, 100.0), 0.0, 100.0) * (global_accuracy/100)
	print("shake_factor")
	print(shake_factor)
	perfect_count.text = "[rainbow][shake][wave]%s" % GlobalVariables.previous_perfect_count
	great_count.text = "[color=lightgreen][shake][wave]%s" % GlobalVariables.previous_great_count
	good_count.text = "[color=dodgerblue][shake]%s" % GlobalVariables.previous_good_count
	miss_count.text = "[color=gray]%s" % GlobalVariables.previous_miss_count
	combo.text = "x%s" % GlobalVariables.previous_best_combo
	accuracy.text = "%.2f%%" % global_accuracy
	if global_score > 500000:
		score.text = "[rainbow][shake level=%s]%s" % [shake_factor, global_score]
	else:
		score.text = "[shake level=%s]%s" % [shake_factor, global_score]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_continuar_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscene_depois_do_teste.tscn")

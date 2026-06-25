extends Control

@onready var perfect_count = $PerfectControl/PerfectCount
@onready var great_count = $GreatControl/GreatCount
@onready var good_count = $GoodControl/GoodCount
@onready var miss_count = $MissControl/MissCount
@onready var accuracy = $AccuracyControl/Accuracy
@onready var score = $Score
@onready var combo = $ComboControl/Combo
@onready var sprite_2d = $Sprite2D


const ORCHESTRA_HIT = preload("uid://cx7n17rl5rh38")


# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_2d.modulate.v = 0.0
	var global_score = GlobalVariables.previous_score
	var global_accuracy = GlobalVariables.previous_accuracy
	var shake_factor = clamp(remap(global_score, 0.0, 250000.0, 0.0, 100.0), 0.0, 100.0) * (global_accuracy/100)
	print("shake_factor")
	print(shake_factor)
	perfect_count.text = "[rainbow][shake][wave]%s" % GlobalVariables.previous_perfect_count
	great_count.text = "[color=lightgreen][shake][wave]%s" % GlobalVariables.previous_great_count
	good_count.text = "[color=dodgerblue][shake]%s" % GlobalVariables.previous_good_count
	miss_count.text = "[color=gray]%s" % GlobalVariables.previous_miss_count
	combo.text = "x%s" % GlobalVariables.previous_best_combo
	accuracy.text = "%.2f%%" % global_accuracy
	if global_score > 250000:
		score.text = "[rainbow][shake level=%s]%s" % [shake_factor, global_score]
	else:
		score.text = "[shake level=%s]%s" % [shake_factor, global_score]

	for child in get_children():
		if not child is Button:
			child.visible = false

	reveal_children()

func reveal_children():
	var player := AudioStreamPlayer.new()
	player.stream = ORCHESTRA_HIT
	add_child(player)

	var pitch := 1.0
	await get_tree().create_timer(0.3).timeout
	var count = 0
	for child in get_children():
		if child == player:
			continue

		if not child is Button:
			child.visible = true

			player.pitch_scale = pitch
			player.play()
			count+=1
			sprite_2d.modulate.v += 0.05
			if count >= 8:
				sprite_2d.modulate.v = 0.5

			pitch += 0.1

			await get_tree().create_timer(0.3).timeout

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_continuar_pressed():
	get_tree().change_scene_to_file("res://scenes/cutscene_depois_do_teste.tscn")

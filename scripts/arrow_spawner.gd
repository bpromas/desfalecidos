extends Node2D

@onready var score_label: Label = $"../ScoreLabel"
@export var arrow_scene : PackedScene
@onready var game = $".."

var travel_time := 1

var bpm := 90.0
var beat_in_sec := 0.67
var first_note_time := 1.7

var notes := [
	"up","left","up","right",
	"down","down","up","left",
	"up","right","down","down",
	"up","left","up","right",
	"down","down","up","left",
	"up","right","down","down",
	"up","left","up","right",
	"down","down","up","left",
	"up","right","down","down",
	"up","left","up","right",
	"down","down","up","left",
	"up","right","down","down",
	"up","left","up","right",
	"down","down","up","left",
	"up","right","down","down",
]

var next_note_index := 0

func spawn_arrow(note):
	var arrow = arrow_scene.instantiate()
	arrow.direction = note
	arrow.target_time = first_note_time + beat_in_sec * next_note_index

	add_child(arrow)

	game.arrows_by_direction[note].append(arrow)

func _ready():
	pass

func _process(delta):
	var current_time = game.get_song_time()

	while next_note_index < notes.size():
		#var note = notes[next_note_index]
		var note = ["up", "down", "left", "right"].pick_random()
		var note_time = first_note_time + beat_in_sec * next_note_index

		if note_time - travel_time <= current_time:
			spawn_arrow(note)
			next_note_index += 1
		else:
			break

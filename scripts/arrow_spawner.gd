extends Node2D

@onready var score_label: RichTextLabel = $"../ScoreLabel"
@export var arrow_scene : PackedScene
@onready var game = $".."

var travel_time := 1

var bpm := 106.0
var beat_in_sec := 60/bpm
var first_note_time := 2.5

var song_is_playing := true

var notes := [
	"up","left","up","right",
]

var next_note_index := 0

func spawn_arrow(note):
	var arrow = arrow_scene.instantiate()
	arrow.missed.connect(_on_arrow_missed)
	arrow.direction = note
	arrow.target_time = first_note_time + beat_in_sec * next_note_index

	add_child(arrow)

	game.arrows_by_direction[note].append(arrow)

func _ready():
	pass

func _process(delta):
	var current_time = game.get_song_time()

	#while song_is_playing:
	while game.get_song_time() <= 129.0:
		var note = ["up", "down", "left", "right"].pick_random()
		var note_time = first_note_time + beat_in_sec * next_note_index

		if note_time - travel_time <= current_time:
			spawn_arrow(note)
			next_note_index += 1
		else:
			break
			
func _on_arrow_missed() -> void:
	game.break_combo()

func _on_audio_stream_player_finished() -> void:
	song_is_playing = false
	pass # Replace with function body.

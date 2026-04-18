extends Node2D

var direction
var target_time
var speed = 256
var time_alive = 0

@onready var label: Label = $Label
@onready var color_rect: ColorRect = $ColorRect

var direction_vector = {
	"up": Vector2.UP,
	"right": Vector2.RIGHT,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
}

func get_rotation_for_direction(dir):
	match dir:
		"up":
			return 0
		"right":
			return deg_to_rad(90)
		"down":
			return deg_to_rad(180)
		"left":
			return deg_to_rad(270)

func hit():
	queue_free()

# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = get_rotation_for_direction(direction)
	var c = color_rect.color
	color_rect.color = Color.from_hsv(rotation, c.s, c.v, c.a)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction_vector[direction] * speed * delta
	
	time_alive += delta
	if time_alive >= 1.5:
		queue_free()
	label.text = str(target_time)

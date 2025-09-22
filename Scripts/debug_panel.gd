extends Control

const _star := preload("res://Scenes/star.tscn")
@onready var _stars_parent: Node2D = $"../../StarsParent"

func _ready() -> void:
	$DebugScroll.hide()
	$DebugButton.pressed.connect(_on_debug_button_pressed)
	for _btn: StarButton in $DebugScroll/DebugContainer.get_children():
		_btn.pressed.connect(_on_spawn_btn_pressed.bind(_btn.get_star_type()))

func _on_spawn_btn_pressed(st: Star.StarType) -> void:
	var _rand_spawn_pos := Vector2(randf_range(10, 500), randf_range(10, 400))
	var _new_star : Star = _star.instantiate()
	_new_star.set_type(st)
	_new_star.global_position = _rand_spawn_pos
	_stars_parent.add_child(_new_star)
	MouseState.play_sound("spawn")
	print("[INFO] Spawn Star with type %s" % [st])

func _on_debug_button_pressed() -> void:
	if $DebugScroll.visible:
		$DebugScroll.hide()
	else:
		$DebugScroll.show()
		

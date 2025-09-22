class_name StarButton extends TextureButton

const _star := preload("res://Scenes/star.tscn")

var _stars_parent: Node2D
var _description_label: Description
@onready var _star_atlas :AtlasTexture = preload("res://Assets/button_atlas.tres")
@onready var _star_atlas_region_size := _star_atlas.region.size

@export var _star_amount := 1 # how many star this button contain
@export var _star_type := Star.StarType.CHOCOLATE
@export var is_debug := false

# NOTE: TYPE : [index X, index Y] -> atlas
var _star_atlas_index := {
	Star.StarType.RED: [0, 0],
	Star.StarType.GREEN: [1, 0],
	Star.StarType.BLUE: [2, 0],
	Star.StarType.PINK: [0, 1],
	Star.StarType.GOLD: [1, 1],
	Star.StarType.CHOCOLATE: [2, 1],
}

func _ready() -> void:
	_set_atlas_button()
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	# not need all of this if the button used for debug panel
	if not is_debug: 
		$AmountLabel.text = str(_star_amount)
		self.pressed.connect(_on_pressed)
		_stars_parent = $"../../../../StarsParent"
		_description_label = $"../../../Description"
	else:
		_description_label = $"../../../../Description"
	
func _on_pressed() -> void:
	if not MouseState.is_holding() and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var _new_star :Star = _star.instantiate()
		_new_star.set_type(_star_type)
		# make the mouse state to dragging and holding star
		_new_star.freeze_physics(false)
		MouseState.set_drag(true)
		MouseState.set_holded_star(_new_star)
		_new_star.global_position = get_viewport().get_mouse_position()
		# ------------------------------------------------------
		_stars_parent.add_child(_new_star)
		print("[INFO] Drag a Star. The Star Type is %s" % [_star_type])
		decrease_star_amount()
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		var _new_star :Star = _star.instantiate()
		_new_star.set_type(_star_type)
		_new_star.global_position = self.global_position + self.size/2.0 # launch from the middle of the button
		_stars_parent.add_child(_new_star)
		_new_star.launch() # launch star
		MouseState.play_sound("launch")
		print("[INFO] Launch a Star. The Star Type is %s" % [_star_type])
		decrease_star_amount()
		

func _set_atlas_button() -> void :
	var _atlas := _star_atlas.duplicate() # duplicate so every button use
	var _idx : Array = _star_atlas_index[_star_type]
	var _pos := Vector2(_star_atlas_region_size.x * _idx[0], _star_atlas_region_size.y * _idx[1])
	_atlas.region.position = _pos
	$StarTexture.texture = _atlas

func increase_star_amount() -> void:
	_star_amount += 1
	$AmountLabel.text = str(_star_amount)

func decrease_star_amount() -> void:
	_star_amount -= 1
	$AmountLabel.text = str(_star_amount)
	if _star_amount == 0:
		self.queue_free()

func set_star_type(s: Star.StarType) -> void:
	_star_type = s

func get_star_type() -> Star.StarType:
	return _star_type

func _on_mouse_entered() -> void:
	var _desc : String
	if not is_debug:
		_desc = "HOLD LEFT CLICK TO DRAG AND\nRIGHT CLICK TO LAUNCH STAR %s" % [_star_type]
	else:
		_desc = "LEFT CLICK TO SPAWN %s ON RANDOM POSITION" % [_star_type]
	_description_label.show_description(is_debug, _desc)

func _on_mouse_exited() -> void:
	_description_label.hide()
